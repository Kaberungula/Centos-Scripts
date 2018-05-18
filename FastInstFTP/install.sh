#!/bin/bash.sh

yum -y install vsftpd
rm -rf /etc/vsftpd/*
cp vsftpd.conf /etc/vsftpd/
useradd -s /sbin/nologin ftp-user
passwd ftp-user
mkdir /etc/vsftpd/users
touch /etc/vsftpd/users/ftp-user
echo 'local_root=/ftp/ftp-user/' >> /etc/vsftpd/users/ftp-user
mkdir /ftp && chmod 0777 /ftp
mkdir /ftp/ftp-user && chown ftp-user. /ftp/ftp-user/
touch /etc/vsftpd/chroot_list
echo 'root' >> /etc/vsftpd/chroot_list
touch /etc/vsftpd/user_list
echo 'root' >> /etc/vsftpd/user_list && echo 'ftp-user' >> /etc/vsftpd/user_list
touch /var/log/vsftpd.log && chmod 600 /var/log/vsftpd.log
systemctl enable vsftpd
systemctl start vsftpd
itog=$(netstat -tulnp | grep vsftpd)
echo "FTP сервер успешно устанволен"
echo $itog
