N=$1
RESDIR=$2
BENCH=md-real-io
M=400
MD_OUTPUT_DIR="/mnt/test/out"
DEVICE_NAME=$3

if [ -d "$MD_OUTPUT_DIR" ]; then
    rm -rf "$MD_OUTPUT_DIR"
fi

TRACEDIR="$RESDIR/$N"
if [ -d "$TRACEDIR" ]; then
    rm -rf "$TRACEDIR"
fi
mkdir -p "$TRACEDIR"

TRACEFILE="md-real-io"
sudo blktrace -d /dev/$DEVICE_NAME -o "$TRACEFILE" -D "$TRACEDIR" &
BLKTRACE_PID=$!

FILE="$TRACEDIR/run_md-real-io.log"
mpiexec -n $N $BENCH -P=$((10000/$N)) -D=20 -I=200 -i=posix -m=$M -R=5 --process-reports -- -D="$MD_OUTPUT_DIR" > $FILE 2>&1

sudo kill -2 $(ps -o pid= --ppid $BLKTRACE_PID)
sudo kill -2 $BLKTRACE_PID

SVGNAME="md-real-io_$N.svg"
iowatcher -t "$TRACEDIR/$TRACEFILE.blktrace" -o "$TRACEDIR/$SVGNAME"

blkparse -i "$TRACEDIR/$TRACEFILE.blktrace.dump" -o "$TRACEDIR/trace.txt"
