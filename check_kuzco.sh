#!/bin/bash
workers=29  # 根据自己GPU能力，更改此数值

while true; do
    if pgrep -x "kuzco-runtime" > /dev/null
    then
        top -b -n 1 | grep --count 'kuzco'
        echo "kuzco-runtime is running."
    else
        echo "kuzco-runtime is not running. Killing all kuzco processes..."
        killall kuzco
        for ((i=0; i<workers; i++)); do 
            (nohup kuzco worker start > /dev/null 2>&1 & sleep 3)
        done
    fi

    # 等待两小时后重启
    echo "Waiting for 2 hours before restarting..."
    sleep 7200
done
