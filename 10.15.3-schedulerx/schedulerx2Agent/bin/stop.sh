#!/usr/bin/env bash

PID="/tmp/${USER}/schedulerx/agent.pid"

if [ -f ${PID} ]; then
    TARGET_PID=`cat ${PID}`
    kill -15 ${TARGET_PID}
    rm ${PID}
    echo "Agent(pid:${TARGET_PID}) stopped successful."
else
    echo "Agent stopped failed! (no agent is found)"
fi
