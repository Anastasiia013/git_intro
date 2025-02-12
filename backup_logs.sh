#!/bin/bash

LOG_DIR="/var/log/httpd"
LOG_FILE="access_log"
BACKUP_DIR="/var/log/httpd/backups"

# Создаем директорию для бэкапов, если её нет
mkdir -p "$BACKUP_DIR"

# Формируем имя архива с датой
DATE=$(date +%Y%m%d)
ARCHIVE="$BACKUP_DIR/$LOG_FILE-$DATE.tar.gz"

# Архивируем лог-файл
tar -czf "$ARCHIVE" "$LOG_DIR/$LOG_FILE"

# Очищаем оригинальный лог-файл после архивации
> "$LOG_DIR/$LOG_FILE"

# Удаляем архивы, которым более 3 дней
find "$BACKUP_DIR" -type f -name "$LOG_FILE-*.tar.gz" -mtime +3 -exec rm {} \;

