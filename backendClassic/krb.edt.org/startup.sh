#!/bin/bash
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid $KRB5KDC_ARGS && echo "kdc started"
/usr/sbin/kadmind -nofork -P /var/run/kadmind.pid $KADMIND_ARGS && echo "kadmin started"
