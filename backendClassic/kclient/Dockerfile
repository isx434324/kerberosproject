#ASIX M11 2017-2018
#Container client detached

FROM fedora:24
MAINTAINER tania@edt "ASIX Client Unix PAM Tania 2018"
RUN dnf -y install nmap iputils procps iproute krb5-libs krb5-workstation pam_krb5 openldap-clients pam-nss-ldapd
RUN mkdir /opt/docker
RUN useradd tania
COPY * /opt/docker/
COPY krb5.conf /etc/
COPY ldap.conf /etc/openldap/.
COPY cacert.pem /etc/openldap/certs/.
COPY nslcd.conf /etc/.
RUN rm -rf /etc/pam.d/system-auth
COPY system-auth /etc/pam.d/ 
WORKDIR /opt/docker
CMD ["/bin/bash"]

