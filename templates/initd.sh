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
	while true; do
		{script} 2> {logs}/{name}.err.log > {logs}/{name}.out.log &
		local PID=$!
		printf $PID > $PIDFILE
		wait $PID
		sleep 1
		[ "$(cat $PIDFILE 2> /dev/null)" != "$PID" ] && exit 0
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
		respawn &
		echo {name} started
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
		kill $(cat $PIDFILE)
		rm -f $PIDFILE
		echo {name} stopped
	else
		echo {name} not running
		rm -f $PIDFILE
		exit 1
	fi
;;
restart)
	$0 stop
	$0 start
;;
esac