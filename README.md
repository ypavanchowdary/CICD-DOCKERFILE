# CICD-DOCKERFILE
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

