#!/bin/bash

function run_day () {
    DAY="${1}"
    USE_QSORT=1
    if [ ${1} -eq 8 ]; then
        USE_QSORT=0
    fi
    if [ ${1} -lt 10 ]; then
        DAY="0${DAY}"
    fi
    echo ""
    echo "----- Day ${DAY} -----"
    DAY="day${DAY}"

    LINK_LIB=""
    if [ ${USE_QSORT} -eq 0 ]; then
        ./libcom/libsort.sh --qsort
        LINK_LIB="-Llibcom/ -lsort"
        export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${PWD}/libcom/"
    fi

    planet -O3 ${LINK_LIB} -o build/${DAY} ${DAY}.plx \
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
