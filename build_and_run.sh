#!/bin/bash

function run_day () {
    DAY="${1}"
    LINK_LIB=""
    if [ ${1} -eq 8 ] ||\
       [ ${1} -eq 9 ]; then
        LINK_LIB="-lqsort"
    fi
    if [ ${1} -lt 10 ]; then
        DAY="0${DAY}"
    fi
    echo ""
    echo "----- Day ${DAY} -----"
    DAY="day${DAY}"

    planet -O3 -E ${DEF_CHECK} ${LINK_LIB} -o build/${DAY} \
        ${DAY}.plx main.plx libcom/libfile.plx
    if [ ${?} -ne 0 ]; then exit 1; fi
    ./build/${DAY}
    if [ ${?} -ne 0 ]; then exit 1; fi
}

ARG=${1}
DEF_CHECK="-DCHECK_ANSWER"
if [ "${1}" = "--no-check" ]; then
    DEF_CHECK=""
    ARG=${2}
fi

mkdir -p build/
if [ ! -z "${ARG}" ]; then
    run_day ${ARG}
else
    for i in $(seq 1 12); do
        run_day ${i}
    done
fi

exit 0
