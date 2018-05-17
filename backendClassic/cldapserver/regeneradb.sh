#!/bin/bash

rm -rf /var/lib/ldap/*
rm -rf /etc/openldap/slapd.d/*
cp DB_CONFIG /var/lib/ldap/.
slaptest -f slapd.conf -F /etc/openldap/slapd.d/
slaptest -f slapd.conf -F /etc/openldap/slapd.d/ -u
chown -R ldap.ldap /var/lib/ldap/
chown -R ldap.ldap /etc/openldap/slapd.d/
slapadd -F /etc/openldap/slapd.d/ -l organitzacio-edt.org.ldif
slapadd -F /etc/openldap/slapd.d/ -l usuaris-edt.org.ldif
chown -R ldap.ldap /var/lib/ldap/
chown -R ldap.ldap /etc/openldap/slapd.d/
