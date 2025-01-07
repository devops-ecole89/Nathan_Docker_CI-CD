### Clone the Python app repo
git clone https://github.com/devops-ecole89/Nathan_PyApp_CI-CD.git ./app

### Moove to the Dev branch
cd app
git checkout dev

### Run the app in test mode
python src/servapp.py -dev > ../logs.txt
cat ../logs.txt
