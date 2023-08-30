#!/bin/bash
awk 'BEGIN {FS="[ =/+]"}
     (NR==1) {title_filename=(FILENAME~/.mgf$/)?substr(FILENAME,1,length(FILENAME)-4):FILENAME}
     ($1=="###MSMS:") {first_scan=$2; last_scan=$(NF-1)}
     ($1!="TITLE") {print $0}
     ($1=="CHARGE") {charge=$2; printf("TITLE=%s.%i.%i.%i\n",title_filename,first_scan,last_scan,charge)}
     {next}
' $1 > $2
