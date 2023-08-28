#!/bin/bash
REFRESH_TOKEN=$1
APP_KEY=$2
SRC_FILES_LOCATION=$3
REMOTE_FILES_LOCATION=$4

SCRIPT_DIR_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# get access token
ACCESS_TOKEN=`python3 $SCRIPT_DIR_PATH/access-token-dropbox.py -r $REFRESH_TOKEN -a $APP_KEY`

# create rclone config
mkdir -p ~/.config/rclone/
$SCRIPT_DIR_PATH/gen-rclone-cfg-dropbox.sh $ACCESS_TOKEN > ~/.config/rclone/rclone.conf

# copy data to dropbox
rclone copy -P --fast-list --checksum --transfers=24 $SRC_FILES_LOCATION remote:$REMOTE_FILES_LOCATION

# remove rclone config
rm -f ~/.config/rclone/rclone.conf
