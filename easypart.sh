#!/bin/bash.sh

DevPath=/dev/
DiskName=''
Size=''

ls -l /dev | grep -n sd

echo -e "#################################"
echo -e "Example: sda , sdb , sdc"
echo -e "#################################"

while [ "$DiskName" = "" ]; do
        echo -e "Input disk name what you need mount: "
        read DiskName
        echo -e "Specify partition size"
        read Size
done

#Create partitions
if [[ -z "lsblk | grep -o ${DiskName}1" ]]; then
parted -a optimal $DevPath$DiskName mkpart primary 0% $Size
mkfs -t ext4 $DevPath${DiskName}1
else
echo -e "Disk already parted"
fi
mount -t ext4 $DevPath${DiskName}1 /opt
echo -e "#################################"
lsblk
echo -e "#################################"
exit 0
