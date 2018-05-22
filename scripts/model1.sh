#!/bin/bash
# Tania Gabriela Bonilla Alvarenga
# HISX2 2017-2018 
# Create images and start docker containers needed for model1
# If you want check the logs , its posible in $LOG_FILE variable

LOG_FILE="/var/tmp/log_model1"
DOCKER_NETWORK="kerberos"
CONTAINER_LDAP="ldap.edt.org"
CONTAINER_KERBEROS="krb.edt.org"
CONTAINER_CLIENT="kclient"
IMAGE_LDAP="ldap.edt.org"
IMAGE_KERBEROS="krb.edt.org"
IMAGE_CLIENT="kclient"

#----------------------------------------------------------------------#

# Stop all containers with this names if running
echo " STOPING CONTAINERS"
docker stop $CONTAINER_LDAP &> $LOG_FILE
docker stop $CONTAINER_KERBEROS &>> $LOG_FILE
docker stop $CONTAINER_CLIENT &>> $LOG_FILE

# Remove all containers with this names
echo " REMOVING CONTAINERS"
docker rm $CONTAINER_LDAP  &>> $LOG_FILE
docker rm $CONTAINER_KERBEROS  &>> $LOG_FILE
docker rm $CONTAINER_CLIENT  &>> $LOG_FILE

# Run Containers
## Docker LDAP
docker run --name $CONTAINER_LDAP \
	--hostname $CONTAINER_LDAP --net $DOCKER_NETWORK \
	--ip 172.11.0.7  --detach $IMAGE_LDAP &>> $LOG_FILE \
	&& echo " Ldap Container Created"

## Docker Kerberos
docker run --name $CONTAINER_KERBEROS \
	--hostname $CONTAINER_KERBEROS --net $DOCKER_NETWORK \
	--ip 172.11.0.2  --detach  $IMAGE_KERBEROS &>> $LOG_FILE \
	&& echo " Kerberos Container Created"
	
## Docker Client
docker run --name $CONTAINER_CLIENT \
	--hostname $CONTAINER_CLIENT --net $DOCKER_NETWORK \
	--ip 172.11.0.3  --detach  $IMAGE_CLIENT &>> $LOG_FILE \
	&& echo " Client Container Created"
	
echo -e "For access: # docker exec -it [Container Name] /bin/bash "
