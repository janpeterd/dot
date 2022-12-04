#!/bin/sh

# This script requires:
	# * pass
	# * pass-import
	# * pass-otp
	# * passmenu-otp-get (for easy usage)

# Paths
aegis_dir="/home/jp/synced/aegis"
keepass_dir="/home/jp/synced/keepass"
database_name="Database.kdbx"
password_store_dir="/home/jp/.local/share/password-store"

# import aegis otp under password subdirectory "otp"
cd $aegis_dir
pass import -p otp "$aegis_dir/$(ls -t | head -1)"

# import keepass passwords
cd $keepass_dir
pass import -p keepass keepass "$keepass_dir/$database_name"
#remove unwanted folders from keepass
rm -r "$password_store_dir/keepass/History"
rm -r "$password_store_dir/keepass/Recycle bin"
