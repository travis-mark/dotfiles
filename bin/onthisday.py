#!/usr/bin/env uv run --script
# /// script
# dependencies = [
#     "rich>=13.0.0",
#     "click>=8.0.0",
#     "pyyaml>=6.0.0",
# ]
# ///

"""
Obsidian Journal Viewer

Reads a folder of Obsidian journal entries and displays entries matching today's month and day
in a rich text viewer. Reads dates from YAML frontmatter in the journal files.
"""

import os
import re
from datetime import datetime
from pathlib import Path
from typing import List, Tuple, Optional

import click
import yaml
from rich.console import Console
from rich.markdown import Markdown
from rich.panel import Panel


def parse_frontmatter(content: str) -> Tuple[Optional[dict], str]:
    """
    Parse YAML frontmatter from markdown content.
    
    Returns:
        Tuple of (frontmatter_dict, remaining_content)
    """
    if not content.startswith('---'):
        return None, content
    
    # Find the end of frontmatter
    parts = content.split('---', 2)
    if len(parts) < 3:
        return None, content
    
    try:
        frontmatter = yaml.safe_load(parts[1])
        remaining_content = parts[2].lstrip('\n')
        return frontmatter, remaining_content
    except yaml.YAMLError:
        return None, content


def extract_date_from_frontmatter(frontmatter: dict) -> Tuple[Optional[int], Optional[int], Optional[int]]:
    """
    Extract date from YAML frontmatter.
    
    Looks for common date fields: date, created, timestamp, etc.
    """
    if not frontmatter:
        return None, None, None
    
    # Common date field names in Obsidian
    date_fields = ['date', 'created', 'timestamp', 'day', 'created_date']
    
    for field in date_fields:
        if field in frontmatter:
            date_value = frontmatter[field]
            
            # Handle different date formats
            if isinstance(date_value, str):
                # Try parsing various date string formats
                date_formats = [
                    '%Y-%m-%d',
                    '%Y/%m/%d',
                    '%m/%d/%Y',
                    '%d/%m/%Y',
                    '%Y-%m-%d %H:%M:%S',
                    '%Y-%m-%dT%H:%M:%S',
                    '%Y-%m-%dT%H:%M',
                    '%Y-%m-%d %H:%M',
                ]
                
                for fmt in date_formats:
                    try:
                        parsed_date = datetime.strptime(date_value, fmt)
                        return parsed_date.year, parsed_date.month, parsed_date.day
                    except ValueError:
                        continue
                
                # Try parsing ISO format with timezone
                try:
                    # Handle ISO format with timezone info
                    if 'T' in date_value and ('+' in date_value or 'Z' in date_value):
                        date_value = re.sub(r'[+-]\d{2}:?\d{2}$|Z$', '', date_value)
                        parsed_date = datetime.fromisoformat(date_value)
                        return parsed_date.year, parsed_date.month, parsed_date.day
                except ValueError:
                    pass
            
            elif hasattr(date_value, 'year'):  # datetime object
                return date_value.year, date_value.month, date_value.day
    
    return None, None, None


def find_matching_entries(journal_dir: Path, target_month: int, target_day: int) -> List[Tuple[Path, int, str]]:
    """Find all journal entries matching the target month and day."""
    matching_entries = []
    
    # Search recursively for markdown files
    for file_path in journal_dir.rglob('*.md'):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            frontmatter, remaining_content = parse_frontmatter(content)
            year, month, day = extract_date_from_frontmatter(frontmatter)
            
            if month == target_month and day == target_day:
                matching_entries.append((file_path, year or 0, remaining_content))
        
        except Exception:
            # Skip files that can't be read
            continue
    
    # Sort by year (put unknown years at the end)
    matching_entries.sort(key=lambda x: x[1] if x[1] else 9999)
    return matching_entries


def get_journal_directory() -> Optional[Path]:
    """
    Get journal directory from environment variable or config file.
    
    Checks in order:
    1. JOURNAL_DIR environment variable
    2. ~/.onthisday config file
    3. Common Obsidian locations
    """
    # Check environment variable first
    env_path = os.getenv('JOURNAL_DIR')
    if env_path:
        path = Path(env_path).expanduser()
        if path.exists():
            return path
    
    # Check config file
    config_file = Path.home() / '.onthisday'
    if config_file.exists():
        try:
            with open(config_file, 'r') as f:
                config_path = f.read().strip()
                if config_path:
                    path = Path(config_path).expanduser()
                    if path.exists():
                        return path
        except Exception:
            pass
    
    # Try common Obsidian locations
    possible_dirs = [
        Path.home() / 'Library' / 'Mobile Documents' / 'iCloud~md~obsidian' / 'Documents' / 'Vault',
        Path.home() / 'Documents' / 'Obsidian' / 'Journal',
        Path.home() / 'Documents' / 'Notes' / 'Journal',
        Path.home() / 'Obsidian' / 'Journal',
        Path.home() / 'Documents' / 'Obsidian Vault' / 'Journal',
        Path.cwd()
    ]
    
    for dir_path in possible_dirs:
        if dir_path.exists() and any(dir_path.rglob('*.md')):
            return dir_path
    
    return None


@click.command()
@click.option(
    '--journal-dir', '-d',
    type=click.Path(exists=True, file_okay=False, dir_okay=True, path_type=Path),
    help='Path to the Obsidian journal directory'
)
@click.option(
    '--date', '-t',
    help='Date to search for (MM-DD format). Defaults to today.'
)
@click.option(
    '--verbose', '-v',
    is_flag=True,
    help='Show verbose output including files that couldn\'t be parsed'
)
def main(journal_dir: Path, date: str, verbose: bool):
    """
    Display Obsidian journal entries matching today's month and day.
    
    This tool searches through your Obsidian journal files and displays all entries
    that match today's month and day from different years, allowing you to review
    what happened on this date in previous years.
    
    The script reads dates from YAML frontmatter in the journal files, looking for
    common date fields like 'date', 'created', 'timestamp', etc.
    
    Configuration (checked in order):
      1. --journal-dir command line option
      2. JOURNAL_DIR environment variable
      3. ~/.onthisday config file (should contain the path)
      4. Common Obsidian vault locations
    """
    console = Console()
    
    # Get target date
    if date:
        try:
            # Add current year to avoid deprecation warning
            current_year = datetime.now().year
            target_date = datetime.strptime(f"{current_year}-{date}", '%Y-%m-%d')
            target_month = target_date.month
            target_day = target_date.day
        except ValueError:
            console.print(f"[red]Error: Invalid date format '{date}'. Use MM-DD format.[/red]")
            return
    else:
        today = datetime.now()
        target_month = today.month
        target_day = today.day
    
    # Get journal directory
    if not journal_dir:
        journal_dir = get_journal_directory()
        
        if not journal_dir:
            console.print("[red]Error: Could not find journal directory.[/red]")
            console.print("\n[dim]You can specify the location by:[/dim]")
            console.print("[dim]  1. Using --journal-dir option[/dim]")
            console.print("[dim]  2. Setting JOURNAL_DIR environment variable[/dim]")
            console.print("[dim]  3. Creating ~/.onthisday file with the path[/dim]")
            return
    
    if verbose:
        console.print(f"[dim]Searching in: {journal_dir}[/dim]")
    
    # Find matching entries
    matching_entries = find_matching_entries(journal_dir, target_month, target_day)
    
    if not matching_entries:
        console.print(f"[yellow]No journal entries found for {target_month:02d}-{target_day:02d}[/yellow]")
        if verbose:
            console.print(f"[dim]Searched {len(list(journal_dir.glob('*.md')))} markdown files[/dim]")
        return
    
    # Display header
    console.print(f"\n[bold blue]Journal entries for {target_month:02d}-{target_day:02d}[/bold blue]")
    console.print(f"[dim]Found {len(matching_entries)} entries in {journal_dir}[/dim]\n")
    
    # Display each entry
    for file_path, year, content in matching_entries:
        # Create title
        title = f"{file_path.name}"
        if year and year != 0:
            title += f" ({year})"
        
        # Display entry in a panel
        try:
            # Try to render as markdown
            if content.strip():
                markdown = Markdown(content)
                panel = Panel(
                    markdown,
                    title=title,
                    title_align="left",
                    border_style="blue"
                )
            else:
                panel = Panel(
                    "[dim]Empty entry[/dim]",
                    title=title,
                    title_align="left",
                    border_style="blue"
                )
        except Exception:
            # Fall back to plain text if markdown fails
            panel = Panel(
                content if content.strip() else "[dim]Empty entry[/dim]",
                title=title,
                title_align="left",
                border_style="blue"
            )
        
        console.print(panel)
        console.print()  # Add spacing between entries


if __name__ == '__main__':
    main()