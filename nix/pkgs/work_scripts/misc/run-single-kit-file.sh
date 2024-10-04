#!/bin/bash

if [ $# -ne 2 ];then
    echo "Usage: run-single-kit-file.sh <product> <kit_ex>"
    echo "Where,"
    echo "  * product is either codeprover of bugfinder"
    echo "  * kit_ex is the example to be tested. e.g. int_zero_div"
    exit 0
fi

product=$1
kit_ex=$2

sbroot=`sbroot`
PATH=$sbroot/matlab/polyspace/bin:$PATH

kit=certkitiec
[ `echo $kit_ex | grep -c jsf` -ne 0 ] && kit=qualkitdo
echo $kit_ex >debug.txt
echo d | ./${kit}_${product}_*.sh

exit $?
