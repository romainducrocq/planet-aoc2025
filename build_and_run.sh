#!/bin/bash

function run_day () {
    DAY="${1}"
    if [ ${1} -lt 10 ]; then
        DAY="0${DAY}"
    fi
    echo ""
    echo "----- Day ${DAY} -----"
    DAY="day${DAY}"

    planet -O3 -o build/${DAY} ${DAY}.plx \
        main.plx libcom/libfile.plx
    if [ ${?} -ne 0 ]; then exit 1; fi
    ./build/${DAY}
    if [ ${?} -ne 0 ]; then exit 1; fi
}

mkdir -p build/
if [ ! -z "${1}" ]; then
    run_day ${1}
else
    for i in $(seq 1 8); do
        run_day ${i}
    done
fi

exit 0
