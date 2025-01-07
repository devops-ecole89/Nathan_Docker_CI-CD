#!/bin/sh

### Build Dockerfile_Dev image
echo "~~ Building image ~~"
sudo docker build -t pyapp-image_dev -f Dockerfile_Dev . > tmp.txt

### Run the Dev container based on Dockerfile_Dev image with the logs.txt file binding
echo "~~ Running container ~~"
sudo docker run --mount type=bind,src=/logs/logs.txt,target=/home/nathan/logs.txt --name pyapp-container_dev pyapp-image_dev

### Get tests results
LogResult=`cat /logs/logs.txt`

### Check LogResult successfull
if [ "$LogResult" = "SUCCESS" ];
then # Merge to staging branch if it's a SUCCESS
        git checkout staging
        git merge -X theirs dev --allow-unrelated-histories
        git push
else
        echo "Test Failed : $LogResult"
fi
