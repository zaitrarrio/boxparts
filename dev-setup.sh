#!/bin/bash

echo 'Setting up your Codio Box for Box Parts development ...'

# Check to see if we have already run this
if [ -d "/home/codio/.parts/autoparts.orig" ]; then
  echo $'Configuration step has already been executed.'
  exit 0
fi

# Move the ~/.parts folder to a new location
# It will not ever need to be accessed but is still there if required
echo $'Moving autoparts folder to a new location'
mv /home/codio/.parts/autoparts /home/codio/.parts/autoparts.orig

# Create a symlink so the original .parts folder is symlinked to
# the workspace folder where our code lives
echo $'Creating symlink'
ln -s /home/codio/workspace /home/codio/.parts/autoparts

echo $'\nFinished!!\n'