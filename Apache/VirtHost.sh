#!/bin/bash.sh

ApacheDIR=/etc/httpd
SiteDIR=/var/www

#Checking the daemon httpd on exist
if [[ -d $ApacheDIR ]]; then
        echo "Httpd detected in system"
else
        echo "Httpd is not installed"
        echo "The script is stopped"
        exit 123
fi

#Make VH-config directory
mkdir $ApacheDIR/sites-available . 2>/dev/null
mkdir $ApacheDIR/sites-enabled . 2>/dev/null

#Add include string to httpd.conf
if [[ -z $(cat $ApacheDIR/conf/httpd.conf | grep sites-enabled) ]]; then
        echo "IncludeOptional sites-enabled/*.conf" >> $ApacheDIR/conf/httpd.conf
fi

#Make VH-Conf
VHname=''
while [ "$VHname" = "" ]; do
        echo -n "Specify the address to virtual host: "
        read VHname
done

port=''
while [ "$port" = "" ]; do
        echo -n "Specify the port to virtual host: "
        read port
done

touch $ApacheDIR/sites-available/$VHname.conf
echo "<VirtualHost *:$port>
        ServerName www.$VHname
        ServerAlias $VHname
        DocumentRoot $SiteDIR/$VHname/public_html
        ErrorLog $SiteDIR/$VHname/error.log
        CustomLog $SiteDIR/$VHname/requests.log combined
</VirtualHost>" > $ApacheDIR/sites-available/$VHname.conf

#Create SiteDir
mkdir -p $SiteDIR/$VHname/public_html
echo "<html>
  <head>
     <title>Welcome to $VHname</title>
  </head>
  <body>
    <h1>Success!!!</h1>
  </body>
</html>" > $SiteDIR/$VHname/public_html/index.html

#Create symlink
ln -s $ApacheDIR/sites-available/$VHname.conf $ApacheDIR/sites-enabled/

#Server restart
systemctl restart httpd
log=$(systemctl status httpd | grep active)
echo $log
echo "VH directory created at address: $SiteDIR/$VHname/public_html"

exit 0
