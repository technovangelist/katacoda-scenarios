#!/bin/sh

echo "waiting for snap to stop" > status.txt
# ssh -oStrictHostKeyChecking=no host01 "sudo systemctl stop snapd.service;sudo systemctl stop docker.service;sudo systemctl stop containerd.service;sudo systemctl stop unattended-upgrades.service"

ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host02 "sudo systemctl stop snapd.service"
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host02 "sudo systemctl stop docker.service"
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host02 "sudo systemctl stop containerd.service"
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host02 "sudo systemctl stop unattended-upgrades.service"

# ssh -oStrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null host03 "sudo systemctl stop snapd.service;sudo systemctl stop docker.service;sudo systemctl stop containerd.service;sudo systemctl stop unattended-upgrades.service"

# ssh -oStrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null host04 "sudo systemctl stop snapd.service;sudo systemctl stop docker.service;sudo systemctl stop containerd.service;sudo systemctl stop unattended-upgrades.service"

# ssh -oStrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null host05 "sudo systemctl stop snapd.service;sudo systemctl stop docker.service;sudo systemctl stop containerd.service;sudo systemctl stop unattended-upgrades.service"
# sudo service docker stop
# sudo service containerd stop

# sudo systemctl disable snapd.service
# sudo service unattended-upgrades stop

# ps cax | grep -v grep | grep snapd | wc -l
# echo $(ps cax | grep -v grep | grep snapd | wc -l) > status.txt
# while [$(ps cax | grep -v grep | grep snapd | wc -l) > 0 )]
# do
# echo "snap is running $(ps cax | grep -v grep | grep snapd | wc -l)" >status.txt
# sleep 1
# done

echo "Setup Installation Framework" > status.txt
apt-add-repository --yes --update ppa:ansible/ansible
apt --yes install ansible

ansible-galaxy install Datadog.datadog


# outputfilename=/root/TrainingEnvironment-$(date +%m%Y%d)
# echo "downloading" > status.txt
# curl -L -J https://github.com/DataDog/TrainingEnvironment/archive/master.zip -o $outputfilename
# echo "unzipping" > status.txt
# printf "\033[31mUnzipping the Training Environment \033[0m\n"
# unzip -q $outputfilename
# mv /root/TrainingEnvironment-master/Datadog101/* /root
# rm -rf /root/TrainingEnvironment-master

# printf "\033[31mConfiguring... \033[0m\n"
# printf "#!/bin/bash\nDD_API_KEY='$DD_API_KEY'\n"> /root/.ddtraining.sh

# echo "Installing the Agent" > status.txt
# DD_API_KEY=${DD_API_KEY} bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"


# sleep 5
echo "done" > status.txt