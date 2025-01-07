# Docker CI/CD 

Here is Docker to create container for the Python Application witch CI/CD. It have two uses :
1. Use the Python Application in a container
2. Performs Tests and CI/CD of the Python Application

Get the Python app here : 

requirements : 
- Docker : `sudo apt install docker`

---
## How to use
It is quit simple, there is only two command :
1. `sh main.sh` : start the Dockerfile_Main for a classic use of the app
2. `sh main.sh -dev` : start the Dockerfile_Dev to test the app and update the git repo

---
## Files
```shell
/
├── logs/
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
With de `-dev` flag, the script run `docker_dev_test.sh` who build the `Dockerfile_Dev` container and run it with a bind of the `logs.txt` file.
The `Dockerfile_Dev` container copy `launch_dev.sh` and run it.
`launch_dev` performs a `git clone` of the python app, `git checkout dev` and then run the app with the `-dev` flag (checkout the readme of the python app).
The output is send to the `logs.txt` witch is shared with the host.
Finally `docker_dev_test.sh` check the `logs.txt` file and if it's a SUCCES then merge dev to staging otherwise echo logs.

---
## Contributors

Nathan: Master mind :)