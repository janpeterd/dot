#/bin/sh
#
# This is just a script that acts as an alias for rsync, that I use to backup files and directories
#
# Depends on: rsync, basename
# If I would want extra functionality in the future, I will add more dependencies to this script.

dir_to_backup="$1"
backup_dir="$2"




# gotify push -t "Backup Synced photos $dir_to_backup" "Started incremental backup $dir_to_backup"

rsync -rahPv --ignore-existing --stats "$dir_to_backup" "$backup_dir"/"$(basename $dir_to_backup)_backup"

# gotify push -t "Backup Synced photos $dir_to_backup" "Finished incremental backup $dir_to_backup"
