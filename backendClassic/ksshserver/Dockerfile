#ASIX M11 2017-2018
#kerberos server
#servidor kerberos detached

FROM fedora:24
MAINTAINER tania@edt "ASIX Client Unix PAM Tania 2018"
RUN dnf -y install passwd nmap iputils iproute openssh-clients openssh-server krb5-workstation
RUN echo jupiter | passwd root --stdin
RUN mkdir /opt/docker
RUN ssh-keygen -A
RUN rm /var/run/nologin
COPY * /opt/docker/
RUN rm -rf /etc/ssh/sshd_config/sshd_config
COPY sshd_config /etc/ssh/
COPY krb5.conf /etc/
#RUN kadmin -p tania/admin -w ktania -q "addprinc -randkey host/sshserver"
#RUN kadmin -p tania/admin -w ktania -q "ktadd -k /etc/krb5.keytab host/ksshserver" 
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]


