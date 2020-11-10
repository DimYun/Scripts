#!/bin/bash

# Check folders
p=""

read -p "Does the smb folder connect to smbFolders/Dmitry? " yn
case $yn in
    [Yy]* ) 
	    p="/home/dmitriy/smbFolders/Dmitry/Backups/";;
	
	[Nn]* )
	    read -p "Does the hadr drive connected to /run/media/dmitriy/Data/? " yn
	        case $yn in
			    [Yy]* ) p="/run/media/dmitriy/Data/Backup/";;
				[Nn]* ) read -p "Input new destination for backup store: " p;;
				* ) echo "Canceled";;
			esac;;
	
	* ) 
	    echo "Canceled";;
esac

# Set test file
# touch /home/dmitriy/scripts/`date "+%Y-%b-%d_%H-%M"`

read -p "Destination for backup is: ${p} continue? " yn
case $yn in
    [Yy]* )
        # Config
		OPT="-aPhrd --force --files-from=/home/dmitriy/scripts/backup_file --delete"
		LINK="${p}Work_arch/snapshots/last/"
		SRC="/"
		SNAP="${p}Work_arch/snapshots/"
		LAST="${p}Work_arch/snapshots/last"
		date=`date "+%Y-%b-%d_%H-%M"`
	    
        # Create all directories
        # echo "Create directories: $LAST and ${SNAP}$date"
		mkdir -pv $LAST
		mkdir -pv ${SNAP}$date

		# Start rsync for snapshot
		echo "Start rsync: " # rsync $OPT $LINK $SRC ${SNAP}$date"
		# rsync $OPT --link-dest=$LINK $SRC ${SNAP}$date > /home/dmitriy/backup_log.txt
		
        rsync $OPT $SRC $LAST                                                          
        cp -al $LAST ${SNAP}$date
        ;;

	[Nn]* )
	    echo "Canceled";;
	
	* ) 
	    echo "Canceled";;
esac

echo "Have a nice day!"
