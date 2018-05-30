#!/bin/bash

#Checking installing bzip2
if [[ -z $(find /usr/bin/ -name "bzip2") ]]; then
echo "#### bzip2 is not install. Now it will be installed####"
sleep 1
yum -y install bzip2
fi

#Checking installing mailx
if [[ -z $(find /usr/bin/ -name "mailx") ]]; then
echo "#### mailx is not install. Now it will be installed####"
sleep 1
yum -y install mailx
fi

#Checking installing rsync
if [[ -z $(find /usr/bin/ -name "rsync") ]]; then
echo "#### rsync is not install. Now it will be installed####"
sleep 1
yum -y install rsync
fi

#Set variables
Data=$(date +%d-%m-%y)
email='*******'
Arcdir='/home/mailbackupreg/mysql'
LettersA='/mnt/mail'
LettersB='/home/mailbackupreg/letter'
Confiles='/home/mailbackupreg/config-files'
diskusr='*******'
diskpass='*******'
user='*******'
passwd='*******'

#Backup
mysqldump -u $user --password=$passwd postfix > \
$Arcdir/postfix.sql
rsync -r $LettersA $LettersB --links
cp -r /etc/dovecot $Confiles/conf/dovecot
cp -r /etc/postfix $Confiles/conf/postfix
tar -cjf $LettersB/mail.tar.bz2 $LettersB/mail
tar -vcjf /home/$Data.tar.bz2 $LettersB/mail \
$Arcdir/postfix.sql $Confiles/conf > /dev/null
curl --user $diskusr:$diskpass -T /home/$Data.tar.bz2 \
https://webdav.yandex.ru/Backups/ --verbose -o /dev/null

#Send email
echo "Backup finished on https://disk.yandex.ru" | \
mail -s $Data -r 'Mailbackup@kaberungula.ru' $email

#Remove archivs
rm -rf $LettersB/mail && rm -f $LettersB/mail.tar.bz2
rm -f $Arcdir/postfix.sql
rm -rf $Confiles/conf/*
rm -f /home/$Data.tar.bz2
exit 0
