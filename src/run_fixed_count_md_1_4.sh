DEVICE_NAME=$1
for N in 1 2 3 4 ; do
    ./fixed_count_md.sh $N ../res/md-real-io $DEVICE_NAME
done
