# We first will give the base image details for the tag "FROM" OS:Version
FROM centos:latest
#who will maintain the image 
MAINTAINER Pavan_Yalamanchili <ypavanchowdary7@gmail.com>

RUN yum install -y httpd initscripts sudo curl ln sed grep egrep fgrep wget git net-tools zip unzip which source openssh-server

#JAVA INSTALLATION
ADD https://s3.amazonaws.com/box-software-all/jdk/jdk-8u144-linux-x64.rpm /
RUN rpm -ivh jdk-8u144-linux-x64.rpm && \
    rm -fr jdk-8u144-linux-x64.rpm
ENV JAVA_HOME="/usr/java/jdk1.8.0_144"  
ENV JRE_HOME="/usr/java/jdk1.8.0_144/jre"


# Grater the RUN Grater the number of layers in an image so use as much less runs as possible 
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original && \
    chmod a-w /etc/ssh/sshd_config.original && \
	mkdir /var/run/sshd && \
	echo 'root:screencast' | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# There should be only 1 CMD for a Docker File	
CMD ["/usr/sbin/sshd, "-D"]
EXPOSE 22 
