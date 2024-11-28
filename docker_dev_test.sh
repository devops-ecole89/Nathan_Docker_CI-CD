#!/bin/sh

echo "~~ Docker container deleted ~~"
sudo docker rm ps web_container -f

echo "~~ Docker image deleted ~~"
sudo docker image rm web_server -f

echo "~~ Building nez image ~~"
sudo docker build -t web_server . > tmp.txt

echo "~~ Running container ~~"
sudo docker run --mount type=bind,src=/logs/logs.txt,target=/home/nathan/logs.txt --name web_container web_server

LogResult=`cat /logs/logs.txt`

if [ "$LogResult" = "SUCCESS" ];
then
	git checkout staging
	git merge dev
else
	echo "Test Failed : $LogResult"
fi
