#!/bin/sh

echo "Serving with uvicorn"
/opt/paso/bin/uvicorn app:app --host 0.0.0.0 --port 8000 &

echo "Installing crontab..."
chmod 0644 /etc/cron.d/pasjonsfrukt-crontab
crontab -r
crontab /etc/cron.d/pasjonsfrukt-crontab
cat /etc/cron.d/pasjonsfrukt-crontab

echo "Starting cron..."
cron && tail -f /var/log/cron.log
