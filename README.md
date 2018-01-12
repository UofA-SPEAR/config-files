# Config-Files
A repo for backing up custom configuration files for the TX2

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
