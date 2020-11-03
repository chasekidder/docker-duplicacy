# Prune backups
# Keep 1 backup every 7 days for backups older than 30 days
/app/duplicacy/duplicacy prune -keep 7:30 
/app/duplicacy/duplicacy prune

