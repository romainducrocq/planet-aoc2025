#!/bin/bash

function run_day () {
    DAY="${1}"
    echo ""
    echo "----- Day ${DAY} -----"
    planet -O3 day0${DAY}.plx libaoc.plx
    if [ ${?} -ne 0 ]; then exit 1; fi
    ./day0${DAY}
    if [ ${?} -ne 0 ]; then exit 1; fi
}

if [ ! -z "${1}" ]; then
    run_day ${1}
else
    for i in $(seq 1 2); do
        run_day ${i}
    done
fi

exit 0
