## SysGuard
A Bash-based system monitoring tool that tracks CPU, RAM, and disk usage 
and alerts when thresholds are exceeded.

Built as a personal project to sharpen Linux and Bash scripting skills.

## Features
- Monitors CPU, RAM, and Disk usage in real time
- Generates alerts when usage exceeds configurable thresholds
- Logs all events with timestamps
- Generates a system report with top processes by CPU
- Runs automatically every 5 minutes via cron job

## Tech Stack
- Bash
- Linux (Ubuntu)
- Cron

## How It Works
1. Script checks system resources
2. Compares against thresholds defined at the top of the script
3. Logs INFO and ALERT messages to logs/sysguard.log
4. Generates a full report to logs/report.log
5. Cron runs the script automatically every 5 minutes

## Configuration
Edit the thresholds at the top of sysguard.sh:

Bash
'''
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=85
'''

## Usage
Bash

# Make executable
  chmod +x sysguard.sh
# Run manually
./sysguard.sh
# Set up cron job (every 5 minutes)
*/5 * * * * /home/bogdan/sysguard/sysguard.sh


## Author
Bogdan Serea
