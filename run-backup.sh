#!/bin/bash

# Start duplicacy backup
cd /src
export DUPLICACY_GCD_TOKEN=/app/gcd-token.json
export DUPLICACY_PASSWORD=[Password Here]

# Initializing GSuite repository
echo Initializing GSUITE Repository
/app/duplicacy/duplicacy init -encrypt gsuite gcd://duplicacy_backups

# Start backup
echo Starting Backup...
#/app/duplicacy/duplicacy backup -limit-rate 8649
/app/duplicacy/duplicacy backup -limit-rate 8650 -stats
