#!/bin/sh

set -e

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DESC="SqueezeCenter Audio Server"
NAME=squeezecenter
DAEMON=/usr/sbin/$NAME-server
DAEMON_SAFE=/usr/sbin/${NAME}_safe
PIDFILE=/var/run/$NAME.pid
#SCRIPTNAME=/etc/init.d/$NAME
USERID=$NAME
#PREFSDIR=/var/lib/$NAME/prefs
PREFSDIR=$SQUEEZE_VOL/prefs
#LOGDIR=/var/log/$NAME/
LOGDIR=$SQUEEZE_VOL/logs
#CACHEDIR=/var/lib/$NAME/cache
CACHEDIR=$SQUEEZE_VOL/cache
CHARSET=utf8

#myip=$( ip addr show eth0 | awk '$1 == "inet" {print $2}' | cut -f1 -d/ )
myip=$( ifconfig eth0 | awk '$1 == "inet" {print $2}' | cut -f2 -d: )
url="http://$myip:9000/"

echo ======================================================================
echo "$url"
echo ======================================================================
echo

exec $DAEMON \
	--diag \
	--user $USERID \
	--charset $CHARSET \
	--prefsdir $PREFSDIR \
	--logdir $LOGDIR \
	--cachedir $CACHEDIR "$@"

