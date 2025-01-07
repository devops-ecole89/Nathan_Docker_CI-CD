#!/bin/sh

### FOR THE BEAUTY ###

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
WHITE='\033[0;37m'
BWHITE='\033[1;37m'

######################

echo "${BWHITE}Enter in docker_dev_test script\n"

### Build Dockerfile_Dev image : pyapp-image_dev
echo "${CYAN}Building image [...]$WHITE\n"
sudo docker build -t pyapp-image_dev -f Dockerfile_Dev . > logs/docker_build.txt

### Run the Dev container based on Dockerfile_Dev image with the logs.txt file binding
echo "${CYAN}Running container [...]$WHITE\n"
sudo docker run --mount type=bind,src=./logs/logs.txt,target=/home/app/logs.txt --name pyapp-container_dev pyapp-image_dev

### Get tests results
LogResult=`cat logs/logs.txt`

### Check LogResult successfull
if [ "$LogResult" = "SUCCESS" ];
then # Merge to staging branch if it's a SUCCESS
	echo "${GREEN}Test succed."
	echo "${YELLOW}Go to PyApp_CI-CD repo to merge [...]"
	cd ../Nathan_PyApp_CI-CD
	echo "${CYAN}Merge ${BWHITE}dev ${CYAN}branch to ${BWHITE}staging\n$WHITE"
        git checkout staging
        git merge -X theirs dev --allow-unrelated-histories

	# Push with the indicate user or not
	if [ ! -z "$1" ];
	then
		/bin/su -s /bin/bash -c "git push" $1
        else
		git push
	fi
	git checkout dev
else
        echo "\nTest Failed : ${RED}${LogResult}\n$WHITE"
fi
