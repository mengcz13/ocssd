DEVICE_NAME=$1
LUN_NUM=$2
sudo nvme lnvm create -d nvme0n1 -t pblk -n $DEVICE_NAME -b 0 -e $((LUN_NUM-1))
sudo mkfs.ext4 /dev/$DEVICE_NAME
sudo mount /dev/$DEVICE_NAME /mnt/test
sudo chown mengcz /mnt/test

#sudo mount /dev/sdb /mnt/data
#sudo chown mengcz /mnt/data
