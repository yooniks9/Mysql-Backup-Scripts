#!/bin/bash
# # MySQL/MariaDB Backup hourly Scripts (MAX:24 backups/day) By: Roy Tan @ Yooniks Co., ltd | Dec 3, 2020
# Database variables (*required)
db_user="db_user"
db_password="db_password"
db_host="127.0.0.1"
db_name="db_name"

# Backup path (DO NOT CHANGE)
path="/home/$USER/SQLbackup/$db_name-daily"
logs="/home/$USER/logs"

# System time variables (DO NOT CHANGE)
day=$(date +"%m.%d.%Y")
fulldate=$(date +"%c")
date=$(date +"%m.%d.%Y-%H:%M")

# Create directory (command)
mkdir -p $path
mkdir -p $logs

# Dump database into SQL file (command)
mysqldump -u$db_user -p$db_password -h$db_host $db_name --skip-lock-tables > $path/$db_name-$date.sql

# Record logs (command)
echo "[hourly] backup $db_name is completed on $fulldate" >> $logs/MySQL-hourly-backup.log

# Clean up files longer than 1 day [ 1 x 1440 = 1440 ] (command)
find $path/*.sql -type f -mmin +1440 -exec rm {} \;
