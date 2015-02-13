set style line 1 lc rgb 'red'

set terminal png size 1280,480
set grid

set title 'WiFi Receive Bytes'
set output 'wifi_recv_bytes.png'
plot 'netcap.log' using 1:2 title "Bytes" with impulses ls 1

set title 'WiFi Receive Packets'
set output 'wifi_recv_packets.png'
plot 'netcap.log' using 1:3 title "Packets" with impulses ls 1

set title 'WiFi Send Bytes'
set output 'wifi_send_bytes.png'
plot 'netcap.log' using 1:4 title "Bytes" with impulses ls 1

set title 'WiFi Send Packets'
set output 'wifi_send_packets.png'
plot 'netcap.log' using 1:5 title "Packets" with impulses ls 1
