#!/bin/bash
username="arcappl"
password="arcappl"
if [ -n "$MYSQL_USER" ];then
    username=$MYSQL_USER
fi
if [ -n "$MYSQL_PASS" ];then
    password=$MYSQL_PASS
fi
echo "* Server MYSQL=$MYSQL_URL ** "
if [ -n "$MYSQL_URL" ];then
    echo "Enabling $MYSQL_URL"
    echo '<?xml version="1.0" encoding="UTF-8"?>
    <Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>WEB-INF/tomcat-web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
    <Resource name="jdbc/archappl"
    auth="Container"
      type="javax.sql.DataSource"
      factory="org.apache.tomcat.jdbc.pool.DataSourceFactory"
      testWhileIdle="true"
      testOnBorrow="true"
      testOnReturn="false"
      validationQuery="SELECT 1"
      validationInterval="30000"
      timeBetweenEvictionRunsMillis="30000"
      maxActive="10"
      minIdle="2"
      maxWait="10000"
      initialSize="2"
      removeAbandonedTimeout="60"
      removeAbandoned="true"
      logAbandoned="true"
      minEvictableIdleTimeMillis="30000"
      jmxEnabled="true"
      driverClassName="com.mysql.jdbc.Driver"' >/usr/local/tomcat/conf/context.xml
      echo "username=\"$username\"" >>/usr/local/tomcat/conf/context.xml
      echo "password=\"$password\"" >>/usr/local/tomcat/conf/context.xml
      echo "url=\"$MYSQL_URL\"" >>/usr/local/tomcat/conf/context.xml
      echo "/>" >>/usr/local/tomcat/conf/context.xml
    echo "</Context>" >> /usr/local/tomcat/conf/context.xml
fi
echo "* Starting Catalina "

catalina.sh run
