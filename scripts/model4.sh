#!/bin/bash
# Tania Gabriela Bonilla Alvarenga
# HISX2 2017-2018 
# Create images and start docker containers needed for model4
# If you want check the logs , its posible in $LOG_FILE variable

LOG_FILE="/var/tmp/log_model4"
DOCKER_NETWORK="kerberos"
CONTAINER_IMAP="kimapserver"
CONTAINER_KERBEROS="krb.edt.org"
CONTAINER_CLIENT="kclient"
IMAGE_IMAP="kimapserver"
IMAGE_KERBEROS="krb.edt.org"
IMAGE_CLIENT="kclient"

#----------------------------------------------------------------------#

# Stop all containers with this names if running
echo " STOPING CONTAINERS"
docker stop $CONTAINER_IMAP &> $LOG_FILE
docker stop $CONTAINER_KERBEROS &>> $LOG_FILE
docker stop $CONTAINER_CLIENT &>> $LOG_FILE

# Remove all containers with this names
echo " REMOVING CONTAINERS"
docker rm $CONTAINER_IMAP  &>> $LOG_FILE
docker rm $CONTAINER_KERBEROS  &>> $LOG_FILE
docker rm $CONTAINER_CLIENT  &>> $LOG_FILE

# Run Containers
## Docker IMAP
docker run --name $CONTAINER_IMAP \
	--hostname $CONTAINER_IMAP --net $DOCKER_NETWORK \
	--ip 172.11.0.6  --detach $IMAGE_IMAP &>> $LOG_FILE \
	&& echo " IMAP Container Created"

## Docker Kerberos

docker run --name $CONTAINER_KERBEROS \
	--hostname $CONTAINER_KERBEROS --net $DOCKER_NETWORK \
	--ip 172.11.0.3  --detach  $IMAGE_KERBEROS &>> $LOG_FILE \
	&& echo " Kerberos Container Created"
	
## Docker Client
docker run --name $CONTAINER_CLIENT \
	--hostname $CONTAINER_CLIENT --net $DOCKER_NETWORK \
	--ip 172.11.0.8  --detach  $IMAGE_CLIENT &>> $LOG_FILE \
	&& echo " Client Container Created"
	
echo -e "For access: # docker exec -it [Container Name] /bin/bash "
