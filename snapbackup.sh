#!/bin/bash

# Check folders
p=""

read -p "Does the smb folder connect to smbFolders/Backup? " yn
case $yn in
    [Yy]* ) 
	    p="absolute_path_to/smbFolders/Dmitry/Backups/";;
	
	[Nn]* )
	    read -p "Does the hadr drive connected to /run/media/user_name/drive_name/? " yn
	        case $yn in
			    [Yy]* ) p="absolute_path_to/user_name/drive_name/Backup/";;
				[Nn]* ) read -p "Input new destination for backup store: " p;;
				* ) echo "Canceled";;
			esac;;
	
	* ) 
	    echo "Canceled";;
esac

# Set test file
# touch /abs_path_to_file/scripts/`date "+%Y-%b-%d_%H-%M"`

read -p "Destination for backup is: ${p} continue? " yn
case $yn in
    [Yy]* )
        # Config
		OPT="-aPhrd --force --files-from=/abs_path_to_script_folder/scripts/backup_file --delete"
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
		# rsync $OPT --link-dest=$LINK $SRC ${SNAP}$date > /abs_path_to_log_file/backup_log.txt
		
        rsync $OPT $SRC $LAST                                                          
        cp -al $LAST ${SNAP}$date
        ;;

	[Nn]* )
	    echo "Canceled";;
	
	* ) 
	    echo "Canceled";;
esac

echo "Have a nice day!"
