#! /bin/bash
#Tania Gabriela Bonilla Alvarenga 
#Insert users in kerberos database from "users" file
#We assume the format of file is one user per line and tania/admin has privileges on kerberos database.

while read -r user
do 
	pass=k$user 
	/usr/bin/kadmin -p tania/admin -w ktania -q "addprinc -pw $pass $user"
done < users.txt


