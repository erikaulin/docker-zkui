#!/bin/bash
#TODO: Rewrite conf
readonly CONFIG_FILE="$APP_DIR/config.cfg" 

# Must be a comma seperated list of all the zookeeper servers
if [ ! -z "$ZK_CONNECTION_STRING" ]; then
    # Default connection string is:
    #   zkServer=localhost:2181,localhost:2181

    # Configure Kafka to connect to not localhost
    sed -r -i "s/(zkServer)=(.*)/\1=$ZK_CONNECTION_STRING/g" $CONFIG_FILE
fi

if [ ! -z "$ZKUI_USER_SET" ]; then
    # Default user set is
    #   userSet = {"users": [{ "username":"admin" , "password":"manager","role": "ADMIN" },{ "username":"appconfig" , "password":"appconfig","role": "USER" }]}

    # Configure custom session timeout
    sed -r -i "s/(userSet )=( .*)/\1=$ZKUI_USER_SET/g" $CONFIG_FILE
fi

if [ ! -z "$ZKUI_SESSION_TIMEOUT" ]; then
    # Default session timeout is
    #   session timeout 5 mins/300 secs.

    # Configure custom session timeout
    sed -r -i "s/(sessionTimeout)=(.*)/\1=$ZKUI_SESSION_TIMEOUT/g" $CONFIG_FILE
fi

# Kick off ZKUI
java -jar /opt/zkui/zkui.jar
