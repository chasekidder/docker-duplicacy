# Source Image
FROM ubuntu:20.04

# Set maintainer information
LABEL maintainer="Chase Kidder"
LABEL version="0.1"
LABEL description="Custom docker for duplicacy backups"


#Update apt cache and install rclone and cron
#RUN apt update && apt install rclone cron -y && apt clean
RUN apt update && apt install cron -y && apt clean

# ===============================================

# Create duplicacy directory 
RUN mkdir -p /app/duplicacy 

# Copy over duplicacy binary 
COPY ./duplicacy /app/duplicacy

# Copy over gsuite account credentials
COPY ./gcd-token.json /app/gcd-token.json

# ================================================

# Copy startup script
COPY ./startup.sh /startup.sh

# Copy run-backup script
COPY ./run-backup.sh /run-backup.sh

# Copy prune-backups script
COPY ./prune-backups.sh /prune-backups.sh

# Change prune-backups script permissions
RUN chmod 775 /prune-backups.sh

# Change run-backup script permissions
RUN chmod 775 /run-backup.sh

# ================================================

# Copy cron file
COPY ./cron-file /etc/cron.d/cron-file

# Change cron file permissions
RUN chmod 644 /etc/cron.d/cron-file

# Add cron-file to cron jobs
RUN crontab /etc/cron.d/cron-file

# ================================================

# Create source volume
RUN mkdir /src
VOLUME /src

# ================================================

# Fix Rclone SSL Issue by adding ssl certs
RUN mkdir -p /etc/ssl/certs
ADD https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt

# =================================================
# Run cron
CMD /bin/sh /startup.sh

