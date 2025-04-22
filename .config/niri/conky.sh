#!/usr/bin/bash
killall conky
sleep 1
LC_TIME=en_US.utf8 conky -c $HOME/.config/conky/Sirius/Sirius.conf
