#ASIX Projecte 2017-2018
#servidor kerberos amb backend ldap amb posibilitat de fer-ho servir detached

FROM fedora:24
MAINTAINER tania@edt "ASIX Kerberos server amb backend ldap 2018"
RUN dnf -y install nmap procps iputils iproute procps krb5-server krb5-libs krb5-workstation krb5-server-ldap openldap-clients openldap-servers
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
COPY krb5.conf /etc/
COPY kdc.conf kadm5.acl /var/kerberos/krb5kdc/
COPY ldap.conf /etc/openldap/
COPY kerberos.schema /etc/openldap/schema/
RUN cp ca* /etc/openldap/certs/
RUN cp server* /etc/openldap/certs/
RUN /opt/docker/regeneradb.sh
#RUN kdb5_ldap_util -D cn=admin,dc=edt,dc=org -w jupiter create -subtrees dc=edt,dc=org -r EDT.ORG -s -P masterkey
#RUN echo -e "jupiter\njupiter" | kdb5_ldap_util -D cn=admin,dc=edt,dc=org -w jupiter stashsrvpw -f /etc/krb5kdc/admin.stash cn=admin,dc=edt,dc=org
CMD ["/opt/docker/startupldap.sh"]
EXPOSE 389 636

