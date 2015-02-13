#! /bin/bash
#
# extract_cpu_clock_percentage.sh
# Copyright (C) 2015 Emiliano Firmino <emiliano.firmino@gmail.com>
#
# Distributed under terms of the MIT license.
#

awk -v OSF=' ' '
    BEGIN {
        N = 12;
        for (i = 0; i < N; i++) {
            prev_count[i] = -1;
        }

        for (i = 0; i < N; i++) {
            freq_count[i] = 0;
        }
    }

    {
        for (i = 0; i < N; i++) {
            freq_usage = $(i + 2);

            if (prev_count[i] == -1) {
                prev_count[i] = freq_usage;
            }

            if (freq_count[i] < freq_usage) {
                freq_count[i] += freq_usage;
            } else {
                freq_count[i] += freq_usage - prev_count[i];
            }

            prev_count[i] = freq_usage;
        }
    }

    END {
        TOTAL = 0;
        for (i = 0; i < N; i++)
        {
            TOTAL += freq_count[i];
        }

        for (i = 0; i < N; i++)  {
            print (freq_count[i] / TOTAL);
        }
    }
    ' $1
