# Profile Columns:
# 1 - datetime
# 2 - time elapsed
# 3 - battery capacity
# 4 - current in milli ampers
# 5 - voltage
# 6 - max designed voltage
# 7 - min designed voltage
# 8 - power in milli watts
# 9 - temperature

set style line 1 lc rgb 'red'
set style line 2 lc rgb 'green'
set style line 3 lc rgb 'yellow'
set style line 4 lc rgb 'royalblue'
set style line 5 lc rgb 'orange'
set style line 6 lc rgb 'brown'
set style line 7 lc rgb 'dark-green'

set terminal png size 10240,1024
set grid

set title  'Battery'
set output 'batt_level.png'
plot 'battmon.log' using 2:($4 / 10) title "Current (0.1mA)" with dots ls 1, \
     'battmon.log' using 2:($5 * 10) title "Voltage (0.1V)"  with dots ls 4,  \
     'battmon.log' using 2:3         title "Capacity (%)"    with dots ls 5

set title 'Voltage'
set output 'batt_voltage.png'
set yrange [0:5]
plot 'battmon.log' using 2:5 title "Now Voltage (V)" with dots ls 4, \
     'battmon.log' using 2:6 title "Max Voltage (V)" with dots ls 2, \
     'battmon.log' using 2:7 title "Min Voltage (V)" with dots ls 1, \
     'battmon.log' using 2:($3 / 20) title "Capacity (20 %)" with dots ls 5

set yrange [*:*]

set title 'Current'
set output 'batt_current.png'
plot 'battmon.log' using 2:4 title "Current (mA)" with dots

set title 'Power'
set output 'power.png'
plot 'battmon.log' using 2:8 title "Power (mW)" with dots

set title 'Temperature'
set output 'batt_temperature.png'
plot 'battmon.log' using 2:9 title "Temperature (C)" with dots


stats "battmon.log" using 2:4 nooutput

max = STATS_max_y
min = STATS_min_y
width=1
hist(x,width)=width*floor(x/width)

set title 'Current Histogram'
set output 'batt_current_histogram.png'
plot 'battmon.log' using (hist($4, width)) : (1.0) smooth freq w impulses lc rgb "red" title "Current Histogram"

stats "battmon.log" using 2:8 nooutput
max = STATS_max_y
min = STATS_min_y
width=1

set title 'Power Histogram'
set output 'batt_power_histogram.png'
plot 'battmon.log' using (hist($8, width)) : (1.0) smooth freq w impulses lc rgb "red" title "Power Histogram"
