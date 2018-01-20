# Config-Files
A repo for backing up custom configuration files for the TX2.

This works by creating a bare git repo and moving the source tree
to the root directory of the file system. It is a convenient method
for backing up specific configuration files which could be difficult
to reconfigure should anything unexpected happen to our system image.

_Note: A bare git repo is a repo that only has the contents you would normally
find in the .git directory._

## Setup
```bash
git init --bare $HOME/.tx2-config
```

## Configuration
```bash
alias config-files='git --git-dir=$HOME/.tx2-config/ --work-tree=$HOME'
config-files remote add origin git@github.com/UofA-SPEAR/config-files.git
config-files config status.showUntrackedFiles no
```

## Usage
Do the following whenever you'd like to add or update a configuration file
```bash
config-files status
config-files add .bashrc
config-files commit -m 'Add bashrc'
config-files push
```

## Replication
```bash
git clone --separate-git-dir=$HOME/.tx2-config https://github.com/UofA-SPEAR/config-files.git tx2-config-tmp
rsync -rv --exclude '.git' tx2-config-tmp/ $HOME/
rm -r tx2-config-tmp
```
