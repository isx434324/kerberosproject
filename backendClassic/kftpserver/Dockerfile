#ASIX M11 2017-2018
#Server ftp kerberitzat

FROM fedora:24
MAINTAINER tania@edt "ASIX Server ftp Kerberitzat Tania 2018"
RUN dnf -y install iputils iproute procps vsftpd ftp krb5-libs krb5-workstation  pam_krb5
RUN mkdir /opt/docker
COPY * /opt/docker/
COPY vsftpd.conf /etc/vsftpd/
COPY krb5.conf /etc/ 
COPY vsftpd /etc/pam.d/
RUN useradd tania
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"] 
EXPOSE 20 21
