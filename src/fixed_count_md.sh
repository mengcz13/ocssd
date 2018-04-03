N=$1
BENCH=md-real-io
M=1000
mpiexec -n $N $BENCH -P=$((10000/$N)) -D=50 -I=200 -i=posix -m=$M -R=5 --process-reports -- -D=/mnt/test/out

