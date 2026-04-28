#!/bin/bash

# ================================
# SysGuard - System Monitor Script
# Author: Bogdan Serea
# ================================

# --- CONFIGURARE ---
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=85
LOG_FILE="$HOME/sysguard/logs/sysguard.log"
REPORT_FILE="$HOME/sysguard/logs/report.log"

# --- FUNCTII ---

get_timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log_alert() {
    echo "[ALERT] $(get_timestamp) - $1" >> "$LOG_FILE"
    echo "[ALERT] $1"
}

log_info() {
    echo "[INFO] $(get_timestamp) - $1" >> "$LOG_FILE"
}

check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    log_info "CPU usage: ${CPU_USAGE}%"
    if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
        log_alert "CPU usage is HIGH: ${CPU_USAGE}% (threshold: ${CPU_THRESHOLD}%)"
    fi
}

check_ram() {
    RAM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    log_info "RAM usage: ${RAM_USAGE}%"
    if [ "$RAM_USAGE" -gt "$RAM_THRESHOLD" ]; then
        log_alert "RAM usage is HIGH: ${RAM_USAGE}% (threshold: ${RAM_THRESHOLD}%)"
    fi
}

check_disk() {
    DISK_USAGE=$(df / | grep / | awk '{print $5}' | cut -d% -f1)
    log_info "Disk usage: ${DISK_USAGE}%"
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        log_alert "DISK usage is HIGH: ${DISK_USAGE}% (threshold: ${DISK_THRESHOLD}%)"
    fi
}

generate_report() {
    echo "================================" >> "$REPORT_FILE"
    echo "SysGuard Report - $(get_timestamp)" >> "$REPORT_FILE"
    echo "================================" >> "$REPORT_FILE"
    echo "CPU Usage:  $(top -bn1 | grep 'Cpu(s)' | awk '{print $2}')%" >> "$REPORT_FILE"
    echo "RAM Usage:  $(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')%" >> "$REPORT_FILE"
    echo "Disk Usage: $(df / | grep / | awk '{print $5}')" >> "$REPORT_FILE"
    echo "Top 5 processes by CPU:" >> "$REPORT_FILE"
    ps aux --sort=-%cpu | head -6 | tail -5 >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# --- MAIN ---
log_info "SysGuard started"
check_cpu
check_ram
check_disk
generate_report
log_info "SysGuard finished"
