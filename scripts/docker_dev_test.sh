
```shell
#!/bin/sh

#echo "~~ Docker container deleted ~~"
#sudo docker rm ps web_container -f

#echo "~~ Docker image deleted ~~"
#sudo docker image rm web_server -f

### Build Dockerfile_Dev image 
echo "~~ Building image ~~"
sudo docker build -t PyAppImage_Dev -f Dockerfile_Dev . > tmp.txt

### Run the Dev container based on Dockerfile_Dev image with the logs.txt file binding
echo "~~ Running container ~~"
sudo docker run --mount type=bind,src=/logs/logs.txt,target=/home/nathan/logs.txt --name PyAppContainer_Dev PyAppImage_Dev

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
```
