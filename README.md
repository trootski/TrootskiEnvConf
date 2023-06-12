These are my personal configuration files, to be shared accross machines.

They're pretty standard

## Installation

The below command will create symlinks for the dotfiles in your home directory. 
It assumes the existence of the folder TrootskiEnvConf in your home folder.

```shell
git clone git@github.com:trootski/TrootskiEnvConf.git ~/TrootskiEnvConf/
source ~/TrootskiEnvConf/setup.sh
```

## Backup

To back up to an external drive execute the following command;

```shell
rsync -aP --delete --exclude-from=/home/troot/TrootskiEnvConf/rsync-homedir-excludes.txt /home/troot /run/media/troot/X220/home-folder-backup
```

