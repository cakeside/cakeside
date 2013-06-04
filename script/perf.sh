ENDPOINT="http://staging.cakeside.com/"
REQUEST_COUNT="100"
THREAD_COUNT="10"

FILENAME="$REQUEST_COUNT.$THREAD_COUNT.$(date +%s)"

mkdir -p tmp/data

# run apache bench performance test
# -k means keep connections alive
echo "/usr/sbin/ab -n $REQUEST_COUNT -c $THREAD_COUNT -g "tmp/data/$FILENAME.dat" $ENDPOINT"
/usr/sbin/ab -n $REQUEST_COUNT -c $THREAD_COUNT -g "tmp/data/$FILENAME.dat" $ENDPOINT

# ctime:  Connection Time
# dtime:  Processing Time
# ttime:  Total Time
# wait:   Waiting Time

mkdir -p tmp/graphs

# create graph
gnuplot << EOF
  # output as png image
  set terminal png
  # save file to "results.png"
  set output "tmp/graphs/$FILENAME.png"
  # graph title
  set title "$REQUEST_COUNT requests on $THREAD_COUNT thread(s)"
  # nicer aspect ratio for image size
  set size 1,0.7
  # y-axis grid
  set grid y
  # x-axis label
  set xlabel "Request"
  # y-axis label
  set ylabel "Total time (ms)"
  #'unique', 'frequency', 'cumulative', 'cnormal', 'kdensity', 'acsplines', 'csplines', 'bezier' or 'sbezier'
  plot "data/$FILENAME.dat" using 9 smooth frequency with lines title "frequency"
EOF

echo "\nResults are in $FILENAME.png\n"
