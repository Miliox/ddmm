set style line 1 lc rgb 'red'

set terminal png size 10240,960
set grid
set yrange [0:4]

set title 'Active CPU Number'
set output 'procnum.png'
plot 'procnum.log' using 1:2 title "Active CPU" with lines ls 1

set title 'CPU0 Active'
set output 'cpu0_active.png'
plot 'cpu0_active.log' using 1:2  title "Active CPU0" with lines ls 1

set title 'CPU1 Active'
set output 'cpu1_active.png'
plot 'cpu1_active.log' using 1:2  title "Active CPU1" with lines ls 1

set title 'CPU2 Active'
set output 'cpu2_active.png'
plot 'cpu2_active.log' using 1:2  title "Active CPU2" with lines ls 1

set title 'CPU3 Active'
set output 'cpu3_active.png'
plot 'cpu3_active.log' using 1:2  title "Active CPU3" with lines ls 1
