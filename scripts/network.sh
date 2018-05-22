#!/bin/bash
# Tania Gabriela Bonilla Alvarenga
# HISX2 2017-2018 
# Script for create and start networks
# If you want check the logs , its posible in $LOG_FILE variable

LOG_FILE="/var/tmp/log_network"
DOCKER_NETWORK="kerberos"


#REMOVE IF EXISTS 
echo " Deleting Network"
docker network rm $DOCKER_NETWORK &>> $LOG_FILE

#CREATE NETWORK
echo " Creating Network"
docker network create --subnet 172.11.0.0/16 --driver bridge \
	$DOCKER_NETWORK &>> $LOG_FILE \
	&& echo " Docker Network $DOCKER_NETWORK Created"

docker network inspect $DOCKER_NETWORK
