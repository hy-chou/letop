#!/bin/bash

if [ $# != 1 ] ; then
    echo -e "
NAME
  \ttop.sh - schedule top logs

SYNOPSIS
  \tbash top.sh DIR

ARGUMENTS
  \tDIR\tabsolute path to the directory to store the data
  \t   \te.g. $HOME/letop/logs

DIRECTIONS
  \tAppend the following lines to /etc/cron.d/letop

DIR_L=$(cd .. && pwd)
 *  *  *  *  * $USER bash \${DIR_L}/scripts/top.sh \${DIR_L}/logs
"
    exit 0
fi

DIR="$1/tops"

mkdir -p "${DIR}"
for i in {0..1}
do
    TS=$(date -u -Iseconds)
    TS2H=$(echo "${TS}" | cut -d : -f 1)

    LINES=$(top -bn 1)

    echo "${TS}" >> ${DIR}/${TS2H}.txt
    echo "${LINES}" >> ${DIR}/${TS2H}.txt

    sleep 30s
done
