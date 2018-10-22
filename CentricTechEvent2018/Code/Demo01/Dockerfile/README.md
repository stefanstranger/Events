# Create Universal Dashboard Container image
docker build --rm -f "CentricTechEvent2018\Code\Demo01\Dockerfile\dockerfile" -t centricud:latest .\CentricTechEvent2018\Code\Demo01\Dockerfile

#run Universal Dashboard Container.
docker run -d -p 8585:8585 --name centric centricud:latest

#Delete all containers.
docker rm -f $(docker ps -a -q)

#Remove Universal Image
docker rmi --force centricud:latest

#Stop Container
docker stop [containerid]

#List all containers
docker ps --all
