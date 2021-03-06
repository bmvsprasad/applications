#!/bin/bash

#Define global APP_ROOT directory
if [ -z "${APP_ROOT}" ]; then
    # Default value
    APP_ROOT=$(cd `dirname $0` ; cd ../../../; pwd)
else
    # Re-declare so it can be used in this script
    APP_ROOT=$(echo $APP_ROOT)
fi
export APP_ROOT=${APP_ROOT}

echo "Start Single Percona Server ......"

${APP_ROOT}/apps/mysql/percona_1/scripts/start_server.sh init
${APP_ROOT}/apps/mysql/percona_1/scripts/start_server.sh start

log_name="./orzdba.log"
if [ ! -z "${1}" ] ;
    log_name=${1}
fi

echo "Start orzdba and tcprstat to catpure latency ......"
orzdba -mysql -i 10 -rt -c -L ${log_name} > /dev/null 2>&1 &
