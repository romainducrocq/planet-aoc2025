#!/bin/bash

LIBCOM_DIR="$(dirname $(readlink -f ${0}))"
LIB="${LIBCOM_DIR}/libsort"
CC="gcc"
if [[ "$(uname -s)" = "Darwin"* ]]; then
    CC="clang -arch x86_64"
fi

CC_FLAGS="-O3 -Wall -Wextra -Wpedantic -pedantic-errors"

if [ "${1}" = "--bsearch" ]; then
    CC_FLAGS="${CC_FLAGS} -DIMPL_BSEARCH"
elif [ "${1}" = "--qsort" ]; then
    CC_FLAGS="${CC_FLAGS} -DIMPL_QSORT"
else
    CC_FLAGS="${CC_FLAGS} -DIMPL_BSEARCH -DIMPL_QSORT"
fi

${CC} ${LIB}.c ${CC_FLAGS} -c -fPIC -o ${LIB}.o
if [ ${?} -ne 0 ]; then exit 1; fi
${CC} ${LIB}.o ${CC_FLAGS} -shared -o ${LIB}.so
if [ ${?} -ne 0 ]; then exit 1; fi

exit 0
