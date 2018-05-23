#!/bin/bash
# Tania Gabriela Bonilla Alvarenga
# HISX2 2017-2018 
# Script for create images
# If you want check the logs , its posible in $LOG_FILE variable

LOG_FILE="/var/tmp/log_images"
DIRCLASSIC="/var/tmp/kerberosproject/backendClassic/"
DIRLDAP="/var/tmp/kerberosproject/backendLDAP/"
IMAGE_KERBEROS="krb.edt.org"
IMAGE_LDAP="ldap.edt.org"
IMAGE_CLIENT="kclient"
IMAGE_SSH="ksshserver"
IMAGE_FTP="kftpserver"
IMAGE_IMAP="kimapserver"
IMAGE_KRBLDAP="krbldap.edt.org"

# Remove Images of all Containers?
#echo " REMOVING IMAGES"
docker rmi -f $IMAGE_KRBLDAP  &>> $LOG_FILE
docker rmi -f $IMAGE_CLIENT   &>> $LOG_FILE
docker rmi -f $IMAGE_SSH      &>> $LOG_FILE
docker rmi -f $IMAGE_FTP      &>> $LOG_FILE
docker rmi -f $IMAGE_IMAP     &>> $LOG_FILE
docker rmi -f $IMAGE_LDAP     &>> $LOG_FILE
docker rmi -f $IMAGE_KERBEROS &>> $LOG_FILE

#echo "CREATING IMAGES"
docker build -t $IMAGE_KERBEROS $DIRCLASSIC$IMAGE_KERBEROS &>> $LOG_FILE
docker build -t $IMAGE_LDAP 	$DIRCLASSIC$IMAGE_LDAP 	&>> $LOG_FILE
docker build -t $IMAGE_CLIENT 	$DIRCLASSIC$IMAGE_CLIENT  &>> $LOG_FILE
docker build -t $IMAGE_SSH 	$DIRCLASSIC$IMAGE_SSH  &>> $LOG_FILE
docker build -t $IMAGE_FTP 	$DIRCLASSIC$IMAGE_FTP  &>> $LOG_FILE
docker build -t $IMAGE_IMAP 	$DIRCLASSIC$IMAGE_IMAP &>> $LOG_FILE
docker build -t $IMAGE_KRBLDAP 	$DIRLDAP  &>> $LOG_FILE

