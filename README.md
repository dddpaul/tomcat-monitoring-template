### tomcat-monitoring-template

This project describes Tomcat configuration changes to allow remote monitoring.

Setup procedure:

**1.** Copy files to Tomcat installation:

```
export CATALINA_HOME=/path/to/tomcat
cp *.sh ${CATALINA_HOME}/bin/
cp jmx.* *.policy *.acl ${CATALINA_HOME}/conf/
```

**2.** Set permissions (use Tomcat process owner instead of tomcat user):

```
chown tomcat ${CATALINA_HOME}/conf/jmx.* ${CATALINA_HOME}/conf/snmp.acl ${CATALINA_HOME}/conf/jstatd.policy
chmod 0600 ${CATALINA_HOME}/conf/jmx.* ${CATALINA_HOME}/conf/snmp.acl ${CATALINA_HOME}/conf/jstatd.policy
```

**3.** Set individual ports in _${CATALINA_HOME}/conf/setenv.sh_, for example:

```
...
-Dcom.sun.management.jmxremote.port=9001
...
-Dcom.sun.management.snmp.port=1611
...
```

**4.** If there is some evil firewall presence then set static RMI server port:

  * Put [catalina-jmx-remote.jar](http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.55/bin/extras/) to _${CATALINA_HOME}/lib_ **(use your version of Tomcat)**.

  * Add listener to _$CATALINA_HOME/conf/server.xml_, for example:

```
<!-- JMX listener for remote debug behind firewall -->
<Listener className="org.apache.catalina.mbeans.JmxRemoteLifecycleListener" rmiRegistryPortPlatform="9001" rmiServerPortPlatform="19001" />
```

  * Then allow inbound TCP connections to ports 9001 and 19001.

  * Remove ```-Dcom.sun.management.jmxremote.port``` option from _${CATALINA_HOME}/conf/setenv.sh_.

**5.** Hostname must be properly resolved on server side! If necessary then add IP-address and FQDN to */etc/hosts*.
