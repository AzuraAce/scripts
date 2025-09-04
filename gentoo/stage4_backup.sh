sudo tar --exclude={"/dev","/proc","/sys","/run","/tmp","/mnt","/media","/lost+found"} \
-cvpzf /home/oliver/backup/stage4-gentoo-$(date +%F).tar.gz /
