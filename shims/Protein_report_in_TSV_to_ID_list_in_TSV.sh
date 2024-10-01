#!/usr/bin/sh
awk '{print $1}' $1 | tr '|' '\n' > $2
