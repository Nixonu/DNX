#!/bin/bash

WALLET=Xwnu11LZqDD9S9eETVevBFStBGvRQnUP4gffjLaFpVNZMDT7EZeo2E4TDgnM4X3qjsZrgfgojbnGEZRVepMAQYce28bauj92E
WORKER=`hostname`
POOL=dnx-eu.ekapool.com
PORT=19666
DEVICES=""

HOME_DIR="/home/user"
MINER_DIR=$HOME_DIR/dynex
MINER_STARTUPLINE="$MINER_DIR/dynexsolve -mining-address $WALLET -no-cpu -multi-gpu -stratum-url $POOL -stratum-port $PORT -stratum-password $WORKER -disable-gpu $DEVICES"


start() {
miner stop
rm $HOME_DIR/dynex_compute_*
rm $HOME_DIR/GPU_*
screen -dmS dnx_miner bash -c "while true; do $MINER_STARTUPLINE; done"
}

stop() {
kill `ps aux |grep "SCREEN.*dnx_miner"|grep -v grep|awk '{print $2}'`
echo -e "${RED}dnx_miner has stopped.${NOCOLOR}"
}


case "$1" in
"") screen -r dnx_miner ;;
"start") start ;;
"stop") stop ;;
"restart") stop; start ;;
*) echo "Unrecongized option '$1'"; usage;;
esac
