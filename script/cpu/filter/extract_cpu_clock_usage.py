#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2015 Emiliano Firmino <emiliano.firmino@gmail.com>
#
# Distributed under terms of the MIT license.

"""
Separate frequency usage by processor
"""

cpu_log = "procmon.log"

def parse_line_and_extract_cpu_freq(out, cpu_tag, col):
    if cpu_tag in col:
        i = col.index(cpu_tag) + 1
        out.write(col[1])
        while (i+1) < len(col) and col[i].isdigit() and col[i+1].isdigit():
            out.write(' ')
            out.write(col[i+1])
            i += 2
        out.write('\n')

cpu0_out = open("cpu0_clock.log", "w+")
cpu1_out = open("cpu1_clock.log", "w+")
cpu2_out = open("cpu2_clock.log", "w+")
cpu3_out = open("cpu3_clock.log", "w+")

with open(cpu_log, "r") as log:
    for line in log:
        line = line.rstrip('\r\n')
        col = line.split(" ")
        parse_line_and_extract_cpu_freq(cpu0_out, "cpu0:", col)
        parse_line_and_extract_cpu_freq(cpu1_out, "cpu1:", col)
        parse_line_and_extract_cpu_freq(cpu2_out, "cpu2:", col)
        parse_line_and_extract_cpu_freq(cpu3_out, "cpu3:", col)

cpu0_out.close()
cpu1_out.close()
cpu2_out.close()
cpu3_out.close()
