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

#MAVEN INSTALLATION
ADD http://apache.mirrors.pair.com/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz /
RUN tar -xvf apache-maven-3.5.0-bin.tar.gz && \
    mv apache-maven-3.5.0 /opt/maven && \
	chmod 755 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn && \
	wget https://s3.amazonaws.com/box-software-all/maven.sh && \
	mv maven.sh /etc/profile.d && \
    chmod 755 /etc/profile.d/maven.sh && \
    rm -fr apache-maven-3.5.0-bin.tar.gz	
	
#JENKINS INSTALLATION
ADD https://s3.amazonaws.com/box-software-all/jenkins /
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo && \
    rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key && \
	yum install -y jenkins && \
	rm -fr /etc/sysconfig/jenkins && \
	mv /jenkins /etc/sysconfig

#TOMCAT 9 INSTALLATION
ADD http://mirror.reverse.net/pub/apache/tomcat/tomcat-9/v9.0.1/bin/apache-tomcat-9.0.1.tar.gz /
ADD https://s3.amazonaws.com/box-software-all/tomcat-users.xml /
RUN tar -xvf apache-tomcat-9.0.1.tar.gz && \ 
    mv apache-tomcat-9.0.1 /opt/tomcat && \
	rm -fr /apache-tomcat-9.0.1.tar.gz && \
	rm -fr /opt/tomcat/conf/tomcat-users.xml && \
	mv /tomcat-users.xml /opt/tomcat/conf 

# Grater the RUN Grater the number of layers in an image so use as much less runs as possible 
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original && \
    chmod a-w /etc/ssh/sshd_config.original && \
	mkdir /var/run/sshd && \
	echo 'root:screencast' | chpasswd && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# There should be only 1 CMD for a Docker File	
CMD ["/usr/sbin/sshd, "-D"]
EXPOSE 22 
#TOMCAT 9 PORT
EXPOSE 8080
#JENKINS PORT
EXPOSE 8082
