#! /bin/bash
#
# active_cpu.sh
# Copyright (C) 2015 Emiliano Firmino <emiliano.firmino@gmail.com>
#
# Distributed under terms of the MIT license.
#

# $2 - Elapsed time since started
# $3 - CPU0 Active? (1- True, 0- False)
# $4 - CPU1 Active? (1- True, 0- False)
# $5 - CPU2 Active? (1- True, 0- False)
# $6 - CPU3 Active? (1- True, 0- False)

CPU_LOG="procmon.log"

awk -v OFS=' ' '{ print $2, ($3+$4+$5+$6); }' $CPU_LOG > cpu_active.log

awk -v OFS=' ' '{ print $2, $3; }' $CPU_LOG > cpu0_active.log
awk -v OFS=' ' '{ print $2, $4; }' $CPU_LOG > cpu1_active.log
awk -v OFS=' ' '{ print $2, $5; }' $CPU_LOG > cpu2_active.log
awk -v OFS=' ' '{ print $2, $6; }' $CPU_LOG > cpu3_active.log

