#! /bin/bash
#Tania Gabriela Bonilla Alvarenga 
#Insert services in kerberos database from "services" file
#We assume:
#	Format of file is one service per line.
#	Service is added for host instance.
#	User tania/admin exist and has privileges on kerberos database.

while read -r service
do 
	/usr/bin/kadmin -p tania/admin -w ktania -q "addprinc -randkey 	host/$service"
done < services.txt
