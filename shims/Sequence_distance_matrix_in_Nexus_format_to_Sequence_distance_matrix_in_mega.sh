#!/usr/bin/sh
awk 'BEGIN {FS="[ |\t]+";}
     /#NEXUS/ {print "#mega"; print "!Title: " FILENAME ";"}
     /\[/ {next}
     /BEGIN/ {B++; next}
     /DIMENSIONS/ {if (B==1) {print "!Format DataType=Distance DataFormat=LowerLeft;"; print ""}}
     (B==1 && $0!~";" && NF==2) {SP[sprintf("%s",$1)]=1; print "#" $2; i++}
     (B==2 && NF>3) {for(j=2;j<2+k;j++) {printf("%s ",$j)}; k++; print ""; }
' $1 > $2
