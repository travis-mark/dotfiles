#!/usr/bin/env uv run --script

import sqlite3
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path
import glob

# Configuration
MAX_BACKUPS = 10

def usage():
    print("Usage: backup-sqlite.py <source_database> <backup_directory>")
    print("")
    print("Arguments:")
    print("  source_database   Path to the SQLite database to backup")
    print("  backup_directory  Directory where backups will be stored")
    print("")
    print("Example:")
    print("  backup-sqlite.py /path/to/mydb.sqlite /path/to/backups")
    sys.exit(1)

def log_message(message, backup_dir):
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_entry = f"{timestamp}: {message}"
    print(log_entry)
    
    log_file = Path(backup_dir) / "backup.log"
    with open(log_file, 'a') as f:
        f.write(log_entry + '\n')

def send_notification(message):
    try:
        subprocess.run(['osascript', '-e', 
                       f'display notification "{message}" with title "SQLite Backup"'],
                      check=True, capture_output=True)
    except subprocess.CalledProcessError:
        pass  # Notification failed, but don't stop the backup

def cleanup_old_backups(backup_dir):
    backup_pattern = str(Path(backup_dir) / "database_backup_*.sqlite")
    backups = sorted(glob.glob(backup_pattern), key=os.path.getmtime, reverse=True)
    
    for old_backup in backups[MAX_BACKUPS:]:
        os.remove(old_backup)
        log_message(f"Removed old backup: {Path(old_backup).name}", backup_dir)

def verify_backup(backup_file, backup_dir):
    try:
        conn = sqlite3.connect(backup_file)
        cursor = conn.cursor()
        cursor.execute("PRAGMA integrity_check;")
        result = cursor.fetchone()[0]
        conn.close()
        return result == "ok"
    except Exception as e:
        log_message(f"Backup verification failed: {e}", backup_dir)
        return False

def perform_backup(source_db, backup_dir):
    log_message(f"Starting backup of {source_db}", backup_dir)
    
    # Check source database
    if not os.path.exists(source_db):
        log_message(f"ERROR: Source database not found: {source_db}", backup_dir)
        send_notification("Backup failed: Source database not found")
        return False
    
    # Create backup directory
    Path(backup_dir).mkdir(parents=True, exist_ok=True)
    
    # Generate backup filename
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_file = Path(backup_dir) / f"database_backup_{timestamp}.sqlite"
    
    try:
        # Connect to source database
        source_conn = sqlite3.connect(source_db)
        
        # Create backup using SQLite's backup API
        backup_conn = sqlite3.connect(str(backup_file))
        source_conn.backup(backup_conn)
        
        # Close connections
        backup_conn.close()
        source_conn.close()
        
        # Verify backup
        if verify_backup(backup_file, backup_dir):
            backup_size = backup_file.stat().st_size / (1024 * 1024)  # MB
            log_message(f"Backup completed: {backup_file.name} ({backup_size:.1f} MB)", backup_dir)
            
            # Cleanup old backups
            cleanup_old_backups(backup_dir)
            
            log_message("Backup completed successfully", backup_dir)
            return True
        else:
            log_message("ERROR: Backup verification failed", backup_dir)
            backup_file.unlink()
            send_notification("Backup failed: Verification failed")
            return False
            
    except Exception as e:
        log_message(f"ERROR: Backup failed: {e}", backup_dir)
        send_notification(f"Backup failed: {e}")
        if backup_file.exists():
            backup_file.unlink()
        return False

def main():
    # Check command line arguments
    if len(sys.argv) != 3:
        usage()
    
    source_db = sys.argv[1]
    backup_dir = sys.argv[2]
    
    log_message("=== SQLite Backup Script Started ===", backup_dir)
    
    if perform_backup(source_db, backup_dir):
        log_message("=== Backup completed successfully ===", backup_dir)
        exit(0)
    else:
        log_message("=== Backup failed ===", backup_dir)
        exit(1)

if __name__ == "__main__":
    main()