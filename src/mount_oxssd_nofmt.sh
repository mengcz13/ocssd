sudo nvme lnvm create -d nvme0n1 --lun-begin=0 --lun-end=3 -n mydevice -t pblk
# sudo fdisk /dev/mydevice
# sudo mkfs.ext4 /dev/mydevice
# sudo mount /dev/mydevice /mnt/test
# sudo chown mengcz /mnt/test

# sudo mount /dev/sdb /mnt/data
# sudo chown mengcz /mnt/data
