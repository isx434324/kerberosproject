#ASIX M11 2017-2018
#ldap server detached
#servidor ldap amb tls i alcs per mantenir una bd kerberos

FROM fedora:24
MAINTAINER tania@edt "ASIX LDAP server per db kerberos 2018"
RUN dnf -y install nmap procps iputils iproute openldap openldap-clients openldap-servers
RUN mkdir /opt/docker
WORKDIR /opt/docker
COPY * /opt/docker/
RUN cp /opt/docker/ca* /etc/openldap/certs/
RUN cp /opt/docker/server* /etc/openldap/certs/
RUN /opt/docker/regeneradb.sh
COPY ldap.conf /etc/openldap/
CMD ["/opt/docker/startup.sh"]
EXPOSE 389 636

