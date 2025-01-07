#!/bin/sh

### FOR THE BEAUTY ###

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
WHITE='\033[0;37m'
BWHITE='\033[1;37m'

######################

perform=""

### Function that delete docker image and container if needed
checkContainerFunction()
{
	echo "${CYAN}Checking for docker to deleted [...]$WHITE"

	# Check witch docker we need to find
	if [ "$perform" = "classic" ];
	then
		docker compose down
		delImage="pyapp-image_app"

	elif [ "$perform" = "dev" ];
	then
		docker rm ps pyapp-container_dev -f
		delImage="pyapp-image_dev"

	else
		return
	fi

	# Search the image
	getImage=`docker image ls | grep $delImage`

	# If there is no Docker img found
	if [ -z "$getImage" ];
	then
		echo "${GREEN}Nothing found$WHITE"
		return
	fi

	# Delete the docker img
	docker image rm $delImage
	echo "${YELLOW}Following Docker image deleted : ${RED}${delImage}\n$WHITE"
}

### Main process
echo "${BWHITE}Starting Script [...]\n"

## Start by checking flags
# Process for the dev use. Perform units tests
if [ "$1" = "-dev" ];
then
	echo "${GREEN}\t~~ Starting App in \"Dev use\" ~~$WHITE\n"
	perform="dev"
	checkContainerFunction
	sh scripts/docker_dev_test.sh
	echo "${GREEN}SUCCESS !"

# Purge the full Docker
elif [ "$1" = "--purge" ];
then
	echo "$CYAN\t~~ Purge Every Docker ~~$WHITE\n"
	docker system prune -a -f

# Process for a classic use of Py App
elif [ "$1" = "" ];
then
	echo "$GREEN\t~~ Starting App in \"Standard use\" ~~$WHITE\n"
	perform="classic"
	checkContainerFunction
	docker compose build --no-cache
	docker compose up
	echo "${GREEN}SUCCESS !"

else
	echo "$RED~Invalid flag"
fi

