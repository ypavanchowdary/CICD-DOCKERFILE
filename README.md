# CICD-DOCKERFILE

# Minimum Basics For Docker File Construction

Dockerfile Commands

ADD – Defines files to copy from the Host file system onto the Container

ADD ./local/config.file /etc/service/config.file

CMD – This is the command that will run when the Container starts

CMD ["nginx", "-g", "daemon off;"]

ENTRYPOINT – Sets the default application used every time a Container is created from the Image. If used in conjunction with CMD, you can remove the application and just define the arguments there
CMD Hello World!

ENTRYPOINT echo

ENV – Set/modify the environment variables within Containers created from the Image.

ENV VERSION 1.0

EXPOSE – Define which Container ports to expose

EXPOSE 80

FROM – Select the base image to build the new image on top of

FROM ubuntu:latest

MAINTAINER – Optional field to let you identify yourself as the maintainer of this image

MAINTAINER Some One "someone@xyz.xyz"

RUN – Specify commands to make changes to your Image and subsequently the Containers started from this Image. This includes updating packages, installing software, adding users, creating an initial database, setting up certificates, etc. These are the commands you would run at the command line to install and configure your application

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

USER – Define the default User all commands will be run as within any Container created from your Image. It can be either a UID or username

USER docker

VOLUME – Creates a mount point within the Container linking it back to file systems accessible by the Docker Host. New Volumes get populated with the pre-existing contents of the specified location in the image. It is specially relevant to mention is that defining Volumes in a Dockerfile can lead to issues. Volumes should be managed with docker-compose or “docker run” commands.

VOLUME /var/log

WORKDIR – Define the default working directory for the command defined in the “ENTRYPOINT” or “CMD” instructions

WORKDIR /home


# SUBJECT: This is a Docker file for constructing a CICD Pipeline with automation of Tests, build and Release Over Docker Mainly With Java as the main Programming Language. 

# Docker Compose Command: $docker build -t pavan/cicd:1 . 
# Docker command to find images built or pulled from dockerhub.com: $docker images -a
# Docker Run an Image: $docker run -it --name pavan_cicd Image_iD /bin/bash

# A few Useful Docker Commands 

docker run it --name My_Name OS/Server:Version /bin/bash

docker rm container_ID

docker rmi Image_ID/Name

docker volume ls 

docker volume rm Volume_Name

some times we have to delete all the volumes Mannually 

so use these  Note we can use the same to stop and remove all the containers 

docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

and then do check 

docker images -a

docker ps 

docker ps -a

List:

docker ps -a |  grep "pattern” 

Remove:

docker ps -a | grep "pattern" | awk '{print $3}' | xargs docker rmi

Remove dangling images:

Docker images consist of multiple layers. Dangling images are layers that have no relationship to any tagged images. 
They no longer serve a purpose and consume disk space. They can be located by adding the filter flag, 
-f with a value of dangling=true to the docker images command. When you're sure you want to delete them, 
you can add the -q flag, then pass their ID to docker rmi

List:

docker images -f dangling=true

Remove:

docker rmi $(docker images -f dangling=true -q)

Remove all Docker Images

docker rmi $(docker images -a -q)


Remove all Exited Containers

List:

docker ps -a -f status=exited

Remove:

docker rm $(docker ps -a -f status=exited -q)


Remove containers using more than one filter

List:

docker ps -a -f status=exited -f status=created

Remove:

docker rm $(docker ps -a -f status=exited -f status=created -q)

Removing Dangling Volumes

List:

docker volume ls -f dangling=true

Remove:

docker volume rm $(docker volume ls -f dangling=true -q)

Remove a Container and It's volume also 

docker rm -v container_name

