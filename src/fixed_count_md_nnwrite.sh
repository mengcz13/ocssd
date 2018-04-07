N=$1
RESDIR=$2
FILESIZE=$3
DEVICE_NAME=$4
BENCH=md-real-io
M=1000
MD_OUTPUT_DIR="/mnt/test/out"

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
# Write only
mpiexec -n $N $BENCH -1 -P=1 -D=1 -I=1 -S=$FILESIZE -i=posix -m=$M -R=5 --process-reports -- -D="$MD_OUTPUT_DIR" > $FILE 2>&1

sudo kill -2 $(ps -o pid= --ppid $BLKTRACE_PID)
sudo kill -2 $BLKTRACE_PID

SVGNAME="md-real-io_$N.svg"
iowatcher -t "$TRACEDIR/$TRACEFILE.blktrace" -o "$TRACEDIR/$SVGNAME"

# rm -rf "$MD_OUTPUT_DIR"
