
time tar --exclude={"/dev","/proc","/sys","/tmp","/run","/mnt","/media","/lost+found"} -cvpzf /home/oliver/backup/gentoo_backup_$(uname -r).$(date +%m%d%y).tar.gz / && echo -e 'Subject: MachineName Backup Complete!!\n\nBackup Complete!!' | sendmail -v user@provider.com

