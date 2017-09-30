# We first will give the base image details for the tag "FROM" OS:Version
FROM centos:latest
#who will maintain the image 
MAINTAINER Pavan_Yalamanchili <ypavanchowdary7@gmail.com>

RUN yum install -y openssh-server 

 
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original 
RUN chmod a-w /etc/ssh/sshd_config.original 
RUN	mkdir /var/run/sshd
RUN	echo 'root:screencast' | chpasswd 
RUN	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
	
CMD ["/usr/sbin/sshd, "-D"]
EXPOSE 22 
