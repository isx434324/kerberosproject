#ASIX M11 2017-2018
#Server telnet kerberitzat

FROM fedora:24
MAINTAINER tania@edt "ASIX Server telnet Kerberitzat Tania 2018"
RUN dnf -y install nmap iputils iproute procps krb5-libs krb5-workstation xinetd  uw-imap pam_krb5 telnet
RUN mkdir /opt/docker
COPY * /opt/docker/
COPY imap /etc/xinetd.d/imap
COPY imappam /etc/pam.d/imap
COPY krb5.conf /etc/ 
RUN useradd pere
RUN useradd tania
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
