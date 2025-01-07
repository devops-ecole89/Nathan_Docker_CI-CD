### Clone the Python app repo
git clone https://github.com/devops-ecole89/Nathan_DevOps.git

### Moove to the Dev branch
cd ./Nathan_DevOps
git checkout dev
cd ../

### Run the app in test mode
python Nathan_DevOps/src/servapp.py -dev > logs.txt
