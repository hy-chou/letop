#!/bin/bash

if [ $# != 1 ] ; then
    echo -e "
NAME
  \tiftop.sh - schedule iftop logs

SYNOPSIS
  \tbash iftop.sh DIR

ARGUMENTS
  \tDIR\tabsolute path to the directory to store the data
  \t   \te.g. $HOME/letop/logs

DIRECTIONS
  \t1. Install iftop
  \t2. Append the following lines to /etc/cron.d/letop

DIR_L=$(cd .. && pwd)
 *  *  *  *  * root bash \${DIR_L}/scripts/iftop.sh \${DIR_L}/logs
"
    exit 0
fi

DIR="$1/iftops"

mkdir -p "${DIR}"
for i in {0..1}
do
    TS=$(date -u -Iseconds)
    TS2H=$(echo "${TS}" | cut -d : -f 1)

    LINES=$(sudo iftop -t -s 30 -L 99)

    echo "${TS}" >> ${DIR}/${TS2H}.txt
    echo "${LINES}" >> ${DIR}/${TS2H}.txt
done
