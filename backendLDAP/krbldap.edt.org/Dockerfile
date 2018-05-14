#ASIX Projecte 2017-2018
#servidor kerberos amb backend ldap amb posibilitat de fer-ho servir detached

FROM fedora:24
MAINTAINER tania@edt "ASIX Kerberos server amb backend ldap 2018"
RUN dnf -y install nmap procps iputils iproute procps krb5-server krb5-libs krb5-workstation krb5-server-ldap openldap-clients
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
COPY krb5.conf /etc/
COPY kdc.conf /var/kerberos/krb5kdc/
COPY ldap.conf /etc/openldap/
COPY cacert.pem /etc/openldap/certs/
#RUN kdb5_ldap_util -D cn=Manager,dc=edt,dc=org -w jupiter -H ldap://ldapserver create -subtrees ou=usuaris,dc=edt,dc=org -r EDT.ORG -P masterkey
#RUN echo -e "jupiter\njupiter" | kdb5_ldap_util -D cn=Manager,dc=edt,dc=org -w jupiter -H ldap://ldapserver stashsrvpw -f /opt/pass-krb.stash cn=Manager,dc=edt,dc=org
#RUN echo -e "jupiter\njupiter" | kdb5_ldap_util -D cn=Manager,dc=edt,dc=org -w jupiter -H ldap://ldapserver stashsrvpw -f /opt/pass-krb.stash cn=kadmin,dc=edt,dc=org
#CMD ["/opt/docker/startup.sh"]
EXPOSE 389 636

