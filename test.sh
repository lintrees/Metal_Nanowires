#!/bin/bash
var_arr[10]="new_element";
d=0;
for INP in *.mphtxt
do
newname=`basename $INP .mphtxt`
newname1=$newname"_cood";
echo $newname1
newname2=$newname"_vertex";
echo $newname2
a=$(sed -n '/# Mesh point coordinates/=' $INP);
b=$(sed -n '/4 # number of element types/=' $INP);
c=$(sed -n '/3 # number of nodes per element/=' $INP);
#(sed -n "$((c+1))"p $INP) | (awk '{split($0, var_arr, " "); printf("%s ",var_arr[1]);}') | echo %
(sed -n "$((c+1))"p $INP) | (awk '{print $1}') > a.txt
while read d; do echo $d;
#d=$(sed -n '/# Geometric entity indices/=' $INP);
(sed -n "$((a+1)), $((b-2))"p $INP) > $newname1.txt
(sed -n "$((c+3)), $((c+d+2))"p $INP) > $newname2.txt
done < a.txt
rm a.txt
done
