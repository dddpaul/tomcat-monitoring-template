#!/bin/sh

if [ ! "`id -u`" -eq 0 ]; then
    echo "Run from super-user please"
    exit 1
fi

if [ -z "$JAVA_HOME" ]; then
    echo "The JAVA_HOME environment variable is not defined"
    echo "This environment variable is needed to run this program"
    exit 1
fi

# Directory of the script + "/.."
APPLICATION_PATH=${0%/*}/..

# JDK has to be installed
JSTATD=$JAVA_HOME/bin/jstatd

if [ ! -f "$JSTATD" ]; then
    echo "$JSTATD is not found, install JDK please"
    exit 1
fi

case "$1" in
    start)
        if [ -z `pidof jstatd` ]; then
            $JSTATD -J-Djava.security.policy=$APPLICATION_PATH/conf/jstatd.policy &
            sleep 3
            PID=`pidof jstatd`
            if [ -n "$PID" ]; then
                echo "jstatd is started, process $PID"
            fi
        fi
        ;;
    stop)
        PID=`pidof jstatd`
        if [ -n "$PID" ]; then
            kill $PID
            echo "jstatd is stopped"
        fi
        ;;
    status)
        PID=`pidof jstatd`
        if [ -n "$PID" ]; then
            echo "jstatd is running, process $PID"
        else
            echo "jstatd is not running"
        fi
        ;;
    *)
        echo "Usage: $0 start|stop|status"
        exit 1
esac
