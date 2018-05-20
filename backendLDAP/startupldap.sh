#! /bin/bash
export TERM=xterm-color
/usr/sbin/slapd -d0 -u ldap -h "ldap:/// ldaps:/// ldapi:///"
