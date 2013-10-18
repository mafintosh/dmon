#!/bin/bash

### BEGIN INIT INFO
# Provides:          {name}
# Required-Start:    $remote_fs $network
# Required-Stop:     $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

PIDFILE={pidfile}
PATH={path}

running () {
	[ ! -f $PIDFILE ] && return 1
	ps -p $(cat $PIDFILE) > /dev/null
	return $?
}

respawn () {
	echo "$RANDOM $RANDOM $RANDOM" > $PIDFILE.lock
	local id=$(cat $PIDFILE.lock)
	while true; do
		{script} 2>> {logs}/{name}.log >> {logs}/{name}.log
		[ "$id" != "$(cat $PIDFILE.lock)" ] && exit 0
		sleep 1
	done
}

case "$1" in
start)
	if running; then
		echo {name} already running
		exit 1
	else
		ulimit -n 10240
		cd "{cwd}"
		respawn 2> /dev/null > /dev/null &
		PID=$!
		printf $PID > $PIDFILE
		echo {name} started
		exit 0
	fi
;;
status)
	if running; then
		echo running
	else
		echo stopped
	fi
;;
stop)
	if running; then
		TMP_PID=$(cat $PIDFILE)
		rm -f $PIDFILE
		rm -f $PIDFILE.lock
		for p in $(ps opgid= $TMP_PID); do
			kill -- -$p > /dev/null 2> /dev/null
		done
		echo {name} stopped
	else
		echo {name} not running
		rm -f $PIDFILE
		rm -f $PIDFILE.lock
		exit 1
	fi
;;
restart)
	$0 stop
	$0 start
;;
esac