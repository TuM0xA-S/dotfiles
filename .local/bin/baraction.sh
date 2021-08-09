#!/bin/bash

conky -t '\
${time %a %d %R %b %y} \
| VOL:${lua_parse pad $pa_sink_volume 2}% \
| BAT:${lua_parse pad $battery_percent 2}%\
${if_match "$acpiacadapter"=="on-line"}C$else $endif \
| ${uppercase ${exec xkb-switch}}
'
