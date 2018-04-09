#!/bin/bash


#WORKINGDIR_NAME=/

echo $USER
echo "Script running"
echo "Server Name --> " ${SERVERNAME-default}



BASE_DIR=~/workspace/runtimes
SERVER_NAME=${SERVERNAME-default}
#WORKINGDIR_NAME=${WORKINGDIR:-"~/aceruntimes/defaultrt"}
WORKINGDIR_NAME=$BASE_DIR/$SERVER_NAME
echo "Runtime directory set to : " $WORKINGDIR_NAME

if [ ! -d "$WORKINGDIR_NAME" ]; then
	echo "directory doesnt exist"
  # Control will enter here if $DIRECTORY doesn't exist.
fi

if [ -z "$WORKINGDIR_NAME" ]
then
      echo "\$WORKINGDIR_NAME is empty"
else
      echo "\$WORKINGDIR_NAME is NOT empty"
			echo $WORKINGDIR_NAME
fi

#if [ ${WORKINGDIR} -ne 0 ]; then
#	WORKINGDIR_NAME=${WORKINGDIR}
#fi
