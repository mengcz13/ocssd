DEVICE_NAME=$1
N=1
for SCALE in 1 10 100 1000 ; do
    ./fixed_count_md_direct.sh $N ../res/md-real-io-direct $DEVICE_NAME $SCALE
done
