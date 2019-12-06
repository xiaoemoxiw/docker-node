#!/usr/bin/env bash

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin"; pwd`

WORKER_PREFIX=`dirname "$bin"`
WORKER_CONF_DIR="${WORKER_PREFIX}/conf"
WORKER_LIB_DIR="${WORKER_PREFIX}/lib"
WORKER_LOG_DIR="${WORKER_PREFIX}/logs"

if [ ! -d "${WORKER_LOG_DIR}" ]; then
    mkdir -p ${WORKER_LOG_DIR}
fi

if [ ! -d "/tmp/${USER}/schedulerx/" ]; then
    mkdir -p /tmp/${USER}/schedulerx/
fi
PID="/tmp/${USER}/schedulerx/agent.pid"

if [ -x "${JAVA_HOME}/bin/java" ]; then
    JAVA="${JAVA_HOME}/bin/java"
else
    JAVA=`which java`
fi

if [ ! -x "${JAVA}" ]; then
    echo "Could not find any executable java binary. Please install java in your PATH or set JAVA_HOME"
    exit 1
fi

MAIN_CLASS="com.alibaba.schedulerx.worker.SchedulerxWorker"

JAVA_OPTS="-Xms512m -Xmx512m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:+UseConcMarkSweepGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${WORKER_LOG_DIR}  -XX:+DoEscapeAnalysis"

if [ -f ${PID} ]; then
    TARGET_PID=`cat ${PID}`
    echo "Agent(pid:${TARGET_PID}) is still running, start failed!"
    exit 1
fi

nohup ${JAVA} ${JAVA_OPTS} -cp .:${WORKER_LIB_DIR}/* \
    ${MAIN_CLASS} ${WORKER_CONF_DIR}/agent.properties > ${WORKER_LOG_DIR}/agent.out 2>&1 < /dev/null &

echo $! > ${PID}
TARGET_PID=`cat ${PID}`
echo "Agent(pid:${TARGET_PID}) started successful."

