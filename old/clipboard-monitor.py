#!/opt/homebrew/bin/python3

from datetime import datetime
import os
import re
import time

import pyperclip

monitors = []

def add_pattern_to_monitor(pattern, callback):
    """
    Monitor clipboard for text matching the given regex pattern.
    
    Args:
        pattern (str): Regular expression pattern to match against
        callback (callable): Function to call when a match is found. Takes the match as an argument.
    """
    regex = re.compile(pattern, re.MULTILINE | re.DOTALL)
    monitors.append((regex, callback))

def monitor_clipboard():
    """
    Start watching clipboard.
    """
    print("Starting clipboard monitor...")
    
    # Keep track of last seen content to avoid duplicate processing
    last_content = None
    
    while True:
        try:
            # Get current clipboard content
            current_content = pyperclip.paste()
            
            # Only process if content has changed
            if current_content != last_content:
                last_content = current_content
                for (regex, callback) in monitors:
                    if match := regex.match(current_content):
                        callback(match)
                        break
                

            # Sleep briefly to reduce CPU usage
            time.sleep(0.5)
            
        except KeyboardInterrupt:
            print("\nStopping clipboard monitor...")
            break
        except Exception as e:
            print(f"Error: {e}")
            time.sleep(1)

def create_append_as_csv_handler(file, delimiter=','):
    """Create a callback to dump regex matches to a CSV file."""
    def on_match_append_as_csv(match):
        print(f'on_match {datetime.now()}')
        with open(file, 'a') as f:
            f.write(f"{datetime.now()}{delimiter}{delimiter.join(group for group in match.groups())}\n")
    return on_match_append_as_csv

if __name__ == "__main__":
    callback = create_append_as_csv_handler("var/lib/data.csv", '|')
    add_pattern_to_monitor(r'(Wordle) (\d{1,4}(?:,?\d{3})*) ([\dX]+)/6(\*?)', callback)
    add_pattern_to_monitor(r'([A-Za-z ]*Octordle) #(\d+).*Score[:] (\d+)()', callback)
    monitor_clipboard()