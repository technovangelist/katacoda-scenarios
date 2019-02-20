#!/bin/sh -x


echo "starting" > status.txt


outputfilename=/root/TrainingEnvironment-$(date +%m%Y%d)
echo "downloading" > status.txt
curl -L -J https://github.com/DataDog/TrainingEnvironment/archive/master.zip -o $outputfilename
echo "unzipping" > status.txt
printf "\033[31mUnzipping the Training Environment \033[0m\n"
unzip -q $outputfilename
mv /root/TrainingEnvironment-master/Datadog101/* /root
rm -rf /root/TrainingEnvironment-master

printf "\033[31mConfiguring... \033[0m\n"
printf "#!/bin/bash\nDD_API_KEY='$DD_API_KEY'\n"> /root/.ddtraining.sh

echo "Installing the Agent" > status.txt
DD_API_KEY=${DD_API_KEY} bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"




echo "done" > status.txt