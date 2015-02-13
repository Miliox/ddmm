#! /bin/bash
#
# extract_cpu_freq.sh
# Copyright (C) 2015 Emiliano Firmino <emiliano.firmino@gmail.com>
#
# Distributed under terms of the MIT license.
#

# $2  - Elapsed time since started
# $7  - CPU0 Frequency
# $8  - CPU1 Frequency
# $9  - CPU2 Frequency
# $10 - CPU3 Frequency

CPU_LOG="procmon.log"

awk '{ OFS=" "; print $2, $7;  }' $CPU_LOG > cpu0_active.log
awk '{ OFS=" "; print $2, $8;  }' $CPU_LOG > cpu1_active.log
awk '{ OFS=" "; print $2, $9;  }' $CPU_LOG > cpu2_active.log
awk '{ OFS=" "; print $2, $10; }' $CPU_LOG > cpu3_active.log

