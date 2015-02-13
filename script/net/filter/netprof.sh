#! /bin/bash
#
# battprocess.sh
# Copyright (C) 2015 ecdmf <ecdmf@Charcoal>
#
# Distributed under terms of the MIT license.
#

awk \
    'BEGIN {
        TXB = 0; TXP = 0;
        RXB = 0; RXP = 0;
     }
     {
        DSB = $3 - TXB;
        DSP = $4 - TXP;
        DRB = $7 - RXB;
        DRP = $8 - RXP;

        if (DSB != 0 ||
            DSP != 0 ||
            DRB != 0 ||
            DRP != 0)
        {
            print $2 " " DSB " " DSP " " DRB " " DRP;
        }

        TXB = $3;
        TXP = $4;
        RXB = $7;
        RXP = $8;
     } ' netmon.log > netcap.log

sed '1d' netcap.log > netcap.bak
sed '$d' netcap.bak > netcap.log
rm netcap.bak
