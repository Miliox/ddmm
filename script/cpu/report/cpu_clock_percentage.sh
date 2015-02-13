#! /bin/bash
#
# extract_cpu_clock_percentage.sh
# Copyright (C) 2015 Emiliano Firmino <emiliano.firmino@gmail.com>
#
# Distributed under terms of the MIT license.
#

if [ "$#" -lt 2 ]; then
FIRST_TIMESTAMP=$(head -n 1 $1 | awk '{ print $1; }')
LAST_TIMESTAMP=$(tail -n 1 $1 | awk '{ print $1 }')

TOTAL_TIME=$(python -c "print $LAST_TIMESTAMP - $FIRST_TIMESTAMP")
else
TOTAL_TIME=$2
fi

awk -v total_time=$TOTAL_TIME '
    BEGIN {
        N = 12;

        # NEXUS 5 CPU Frequencies
        freq[0] = 384;
        freq[1] = 486;
        freq[2] = 594;
        freq[3] = 702;
        freq[4] = 810;
        freq[5] = 918;
        freq[6] = 1026;
        freq[7] = 1134;
        freq[8] = 1242;
        freq[9] = 1350;
        freq[10] = 1458;
        freq[11] = 1512;

        for (i = 0; i < N; i++) {
            prev_count[i] = -1;
        }

        for (i = 0; i < N; i++) {
            freq_count[i] = 0;
        }

        prev_timestamp = 0;
        total_sleep = 0;
    }

    {
        has_sleep = 0;
        for (i = 0; i < N; i++) {
            freq_usage = $(i + 2);

            if (prev_count[i] == -1) {

                prev_count[i] = freq_usage;
                prev_timestamp = $1;
                total_sleep = $1;
            }

            if (freq_count[i] < freq_usage) {
                freq_count[i] += freq_usage;
                has_sleep = 1;
            } else {
                freq_count[i] += freq_usage - prev_count[i];
            }

            prev_count[i] = freq_usage;
        }

        if (has_sleep) {
            print $1, " ", prev_timestamp, " ", $1 - prev_timestamp;
            total_sleep += $1 - prev_timestamp;
        }

        prev_timestamp = $1;
    }

    END {
        total_sleep += total_time - prev_timestamp;

        TOTAL = 0;
        for (i = 0; i < N; i++) {
            TOTAL += freq_count[i];
        }

        print total_sleep;
        print total_time;
        printf("sleep: %0.3f%%\n", (total_sleep / total_time) * 100);
        for (i = 0; i < N; i++)  {
            printf("%0.3f%% %dKHz\n", ((freq_count[i] * 100)/TOTAL), freq[i]);
        }
    }
    ' $1
