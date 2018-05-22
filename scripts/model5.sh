#!/bin/bash
# Tania Gabriela Bonilla Alvarenga
# HISX2 2017-2018 
# Create images and start docker containers needed for model5
# If you want check the logs , its posible in $LOG_FILE variable

LOG_FILE="/var/tmp/log_model5"
DOCKER_NETWORK="kerberos"
CONTAINER_KERBEROSLDAP="krbldap.edt.org"
IMAGE_KERBEROSLDAP="krbldap.edt.org"

#----------------------------------------------------------------------#

# Stop all containers with this names if this is running
echo " STOPING CONTAINERS"
docker stop $CONTAINER_KERBEROSLDAP &> $LOG_FILE

# Remove all containers with this names
echo " REMOVING CONTAINERS"
docker rm $CONTAINER_KERBEROSLDAP  &>> $LOG_FILE

# Run Container
## Docker Kerberos
docker run --name $CONTAINER_KERBEROSLDAP \
	--hostname $CONTAINER_KERBEROSLDAP --net $DOCKER_NETWORK \
	--ip 172.18.0.11  --detach  $IMAGE_KERBEROSLDAP &>> $LOG_FILE \
	&& echo " Kerberos Container Created"
		
echo -e "For access: # docker exec -it [Container Name] /bin/bash "
