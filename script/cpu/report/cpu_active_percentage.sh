#! /bin/bash
#
# extract_cpu_clock_percentage.sh
# Copyright (C) 2015 Emiliano Firmino <emiliano.firmino@gmail.com>
#
# Distributed under terms of the MIT license.
#

awk '
    BEGIN {
        total_active = 0;
        total_sleep = 0;

        prev_timestamp = 0.0;
    }

    {
        elapsed = $1 - prev_timestamp;
        if (int($2)) {
            total_active += elapsed;
        } else {
            total_sleep += elapsed;
        }

        prev_timestamp = $1;
    }

    END {
        total_time = total_active + total_sleep;

        printf("on: %0.3f%%\n", (total_active / total_time) * 100);
        printf("off: %0.3f%%\n", (total_sleep / total_time) * 100);
    }
    ' $1
