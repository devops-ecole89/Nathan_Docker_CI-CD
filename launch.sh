# ssh-add ./.ssh/id_rsa
#git config --global core.sshCommand 'ssh -i /home/nathan/.ssh/id_rsa'
git clone https://github.com/devops-ecole89/Nathan_DevOps.git
cd ./Nathan_DevOps
git checkout dev
cd ../
python Nathan_DevOps/src/servapp.py -dev > logs.txt
