#!/bin/bash
# Tania Gabriela Bonilla Alvarenga
# HISX2 2017-2018 
# Create images and start docker containers needed for model3
# If you want check the logs , its posible in $LOG_FILE variable

LOG_FILE="/var/tmp/log_model3"
DOCKER_NETWORK="kerberos"
CONTAINER_FTP="kftpserver"
CONTAINER_KERBEROS="krb.edt.org"
CONTAINER_CLIENT="kclient"
IMAGE_FTP="kftpserver"
IMAGE_KERBEROS="krb.edt.org"
IMAGE_CLIENT="kclient"

#----------------------------------------------------------------------#

# Stop all containers with this names if running
echo " STOPING CONTAINERS"
docker stop $CONTAINER_FTP &> $LOG_FILE
docker stop $CONTAINER_KERBEROS &>> $LOG_FILE
docker stop $CONTAINER_CLIENT &>> $LOG_FILE

# Remove all containers with this names
echo " REMOVING CONTAINERS"
docker rm $CONTAINER_FTP  &>> $LOG_FILE
docker rm $CONTAINER_KERBEROS  &>> $LOG_FILE
docker rm $CONTAINER_CLIENT  &>> $LOG_FILE

# Run Containers
## Docker FTP
docker run --name $CONTAINER_FTP \
	--hostname $CONTAINER_FTP --net $DOCKER_NETWORK \
	--ip 172.11.0.5  --detach $IMAGE_FTP &>> $LOG_FILE \
	&& echo " FTP Container Created"

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
	
echo -e "For Access: # docker exec -it [Container Name] /bin/bash "
