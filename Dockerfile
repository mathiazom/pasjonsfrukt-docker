FROM python:3

RUN apt update && \
apt -y install cron && \
apt -y install ffmpeg

# Set local timezone (for cron)
RUN ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

# Create cron log file to be able to run tail
RUN touch /var/log/cron.log

EXPOSE 8000

COPY pasjonsfrukt/requirements.txt pasjonsfrukt/requirements.txt

WORKDIR pasjonsfrukt/

RUN python -m venv /opt/paso && /opt/paso/bin/pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh  /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY pasjonsfrukt/ .

CMD ["/bin/bash", "entrypoint.sh"]
