#!/bin/sh

# Memory limits and GC
#CATALINA_OPTS="${CATALINA_OPTS} -Xms256m -Xmx256m -XX:PermSize=96m -XX:MaxPermSize=96m -XX:+UseConcMarkSweepGC"
#CATALINA_OPTS="${CATALINA_OPTS} -Xms256m -Xmx256m -XX:MetaspaceSize=96m -XX:MaxMetaspaceSize=96m -XX:+UseConcMarkSweepGC"
CATALINA_OPTS="${CATALINA_OPTS} -XX:+UseConcMarkSweepGC"

# Enable GC verbose logging
CATALINA_OPTS="${CATALINA_OPTS} -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError"

# Output GC log to file and rotate it
CATALINA_OPTS="${CATALINA_OPTS} -Xloggc:${CATALINA_HOME}/logs/memory.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=3 -XX:GCLogFileSize=100M"

# Enable JMX remote access
# If JmxRemoteLifecycleListener (catalina-jmx-remote.jar) is used then remove "com.sun.management.jmxremote.port" option
CATALINA_OPTS="${CATALINA_OPTS} \
-Dcom.sun.management.jmxremote.port=9000 \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=true \
-Dcom.sun.management.jmxremote.access.file=${CATALINA_HOME}/conf/jmx.access \
-Dcom.sun.management.jmxremote.password.file=${CATALINA_HOME}/conf/jmx.password"

# Enable SNMP remote access
CATALINA_OPTS="${CATALINA_OPTS} \
-Dcom.sun.management.snmp.port=1612 \
-Dcom.sun.management.snmp.acl.file=${CATALINA_HOME}/conf/snmp.acl \
-Dcom.sun.management.snmp.interface=0.0.0.0"

# Speed up application startup
CATALINA_OPTS="${CATALINA_OPTS} -Djava.security.egd=file:/dev/urandom"

# Enable for ojdbc7 driver
CATALINA_OPTS="${CATALINA_OPTS} -Duser.timezone=Europe/MSK"
