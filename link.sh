#!/bin/bash

# Files to exclude from the linking step
EXCLUSIONS=".git .Xresources .config README.md link.sh .fehbg"
# Files to copy to the home directory rather than link, must also be excluded above
COPIES=".Xresources"

# Set variables for dotfiles direcory
GIT_DIR=$(dirname $(readlink -f $0))

echo "Linking files from $GIT_DIR"

# Scan all files in the git direcotry
cd $HOME/
MATCHES=$(ls -A $GIT_DIR)

# Itterate through the matches
for MATCH in $MATCHES
do
if echo $EXCLUSIONS | grep -w $MATCH > /dev/null
then
	# Exclude matches present in the EXCLUSIONS variable
	echo "Skipping $MATCH"
else
	# Remove existing files (or links) and create symbolic links to the files in the git repo
	rm ./$MATCH
	ln -sf $GIT_DIR/$MATCH .
	echo "replaced $MATCH"
fi
done

# Itterate through the copies variable
for COPY in $COPIES
do
	if [ ! -f $HOME/$COPY ]
	then
		# if the file doesn't already exist in the home directory then copy the file to the home folder
		cp $GIT_DIR/$COPY $HOME
		echo "$COPY missing, copying"
	fi
done

# The same as above for the .config folder
cd $HOME/.config
MATCHES=$(ls -A $GIT_DIR/.config)

for MATCH in $MATCHES
do
if echo $EXCLUSIONS | grep -w $MATCH > /dev/null; then
	echo "Skipping .config/$MATCH"
else
	rm ./$MATCH
	ln -sf $GIT_DIR/.config/$MATCH .
	echo "replaced .config/$MATCH"
fi
done