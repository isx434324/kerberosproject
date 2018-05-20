#ASIX M11 2017-2018
#kerberos server
#servidor kerberos detached

FROM fedora:24
MAINTAINER tania@edt "ASIX kerberos server Backend Classic 2018"
RUN dnf -y install nmap iputils iproute krb5-libs krb5-server krb5-workstation
RUN mkdir /opt/docker
COPY * /opt/docker/
COPY krb5.conf /etc/
COPY kdc.conf kadm5.acl /var/kerberos/krb5kdc/
RUN /usr/sbin/kdb5_util create -P masterkey -s
RUN kadmin.local -r EDT.ORG -q "addprinc -pw ktania tania"
RUN kadmin.local -r EDT.ORG -q "addprinc -pw ktania tania/admin"
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
EXPOSE 749 464 88

