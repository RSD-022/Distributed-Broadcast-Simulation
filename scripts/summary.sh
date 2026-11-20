#!/bin/bash
# Usage, from simulations/:  ../scripts/summary.sh V2_Line6
opp_scavetool query -l results/"$1"/*.sca | awk '/:$/{if(r)p(); r=$1; delete s; t=0; next} $1=="scalar"{if($3=="firstReceptionTime"){if($4>t)t=$4}else s[$3]+=$4} function p(){printf "sent=%d received=%d duplicates=%d informed=%d lastArrival=%ss\n",s["sent"],s["received"],s["duplicates"],s["informed"],t} END{if(r)p()}'
