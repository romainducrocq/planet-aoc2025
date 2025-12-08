#!/bin/bash

function build_so () {
    LIB="${1}"
    LINK_LIB="${LINK_LIB} -l${LIB}"

    CC="gcc"
    if [[ "$(uname -s)" = "Darwin"* ]]; then
        CC="clang -arch x86_64"
    fi

    ${CC} ${LIB}.c -c -fPIC -o "build/${LIB}.o"
    if [ ${?} -ne 0 ]; then exit 1; fi
    ${CC} "build/${LIB}.o" -shared -o "build/lib${LIB}.so"
    if [ ${?} -ne 0 ]; then exit 1; fi
}

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
        build_so "qsort"
    fi
    if [ ! -z "${LINK_LIB}" ]; then
        LINK_LIB="-Lbuild/ ${LINK_LIB}"
        export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${PWD}/build/"
    fi

    planet -O3 ${LINK_LIB} -o build/${DAY} ${DAY}.plx \
        main.plx libcom/libfile.plx
    if [ ${?} -ne 0 ]; then exit 1; fi
    ./build/${DAY}
    if [ ${?} -ne 0 ]; then exit 1; fi
}

LINK_LIB=""
mkdir -p build/
if [ ! -z "${1}" ]; then
    run_day ${1}
else
    for i in $(seq 1 8); do
        run_day ${i}
    done
fi

exit 0
