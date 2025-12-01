#!/bin/bash

planet -O3 day${1}.plx
if [ ${?} -ne 0 ]; then exit 1; fi

./day${1}
if [ ${?} -ne 0 ]; then exit 1; fi

exit 0
