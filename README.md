# Docker CI/CD 

Here is Docker to create container for the Python Application witch CI/CD. It have two uses :
1. Use the Python Application in a container
2. Performs Tests and CI/CD of the Python Application

Get the Python app here : https://github.com/devops-ecole89/Nathan_PyApp_CI-CD.git

requirements : 
- Docker : `sudo apt install docker`
- Put the Python App directory and the Docker CI/CD in the same **directory**
```shell
/                         # Global directory
├── Nathan_PyApp_CI-CD/   # PyApp directory
└── Nathan_Docker_CI-CD/  # Docker directory
```
- For the good work of the `docker_dev_test.sh` script **PLEASE DO NOT CHANGE** the repo directory name witch is "Nathan_PyApp_CI-CD"

---
## How to use
It is quit simple, there is only two command :
1. `sh main.sh` : start the Dockerfile_Main for a classic use of the app
2. `sh main.sh -dev` : start the Dockerfile_Dev to test the app and update the git repo
	- You can add a user in a second argument. The script will take the indicate user to perform the git push command.
	- The other solution is to run `git config --add --local core.sshCommand 'ssh -i /home/${user}/.ssh/${private_ssh_key}'
	- One of those solution is required if you run the script in sudo mode (In my case, I have to for the execution of docker command)

---
## Files
```shell
/
├── logs/
│	├── docker_build.txt    # Log file for docker build image
│   └── logs.txt            # Log file for the docker_dev_test execution
├── scripts/
│	├── launch_dev.sh       # Shell script for the Dockerfile_Dev container
│	└── docker_dev_test.sh  # Shell script that prepare and do all the process for tests and CI/CD tasks
├── compose.yml             # Basic compose for the Dockerfile_Main container
├── main.sh                 # Main shell script that run the main container or the dev one
├── Dockerfile_Dev          # Dev container to performs tests
├── Dockerfile_Main         # Main container for the classic app
└── README.md               # Project documentation
```

---
## How it works
### Classic app
The basic way just execute `docker compose up` that start the `compose.yml` who build the `Dockerfile_Main`. 
`Dockerfile_Main` clone the python app repo and run it.

### Test app
With the `-dev` flag, the script run `docker_dev_test.sh` who build the `Dockerfile_Dev` container and run it with a bind of the `logs.txt` file.
The `Dockerfile_Dev` container copy `launch_dev.sh` and run it.
`launch_dev` performs a `git clone` of the python app, `git checkout dev` and then run the app with the `-dev` flag (checkout the readme of the python app).
The output is send to the `logs.txt` witch is shared with the host.
Finally `docker_dev_test.sh` check the `logs.txt` file and if it's a SUCCES then merge dev to staging otherwise echo logs.

### Purge
With the `--purge` flag will execute `docker system prune -a` and purge all of your docker.

---
## Contributors

Nathan: Master mind :)