#!/bin/bash

set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)

BACKUP_DIR="$HOME/backups"

mkdir -p $BACKUP_DIR

MYSQL_POD=$(kubectl get pods -n skillpulse -l app=mysql -o jsonpath="{.items[0].metadata.name}")

kubectl exec -n skillpulse $MYSQL_POD -- \
mysqldump -u root -prootpassword123 skillpulse \
> $BACKUP_DIR/skillpulse_$TIMESTAMP.sql

find $BACKUP_DIR -type f -mtime +7 -delete

echo "Backup completed successfully"
















