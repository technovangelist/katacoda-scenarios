#!/bin/sh -x


echo "starting" > status.txt


printf "\033[31mDownloading the Training Environment from Github \033[0m\n"
outputfilename=/root/TrainingEnvironment-$(date +%m%Y%d)
echo "downloading" > status.txt
curl -L -J https://github.com/DataDog/TrainingEnvironment/archive/master.zip -o $outputfilename
echo "unzipping" > status.txt
printf "\033[31mUnzipping the Training Environment \033[0m\n"
unzip -q $outputfilename
mv /root/TrainingEnvironment-master/Datadog101/* /root
rm -rf /root/TrainingEnvironment-master

printf "\033[31mConfiguring... \033[0m\n"
printf "#!/bin/bash\nDD_API_KEY='$apikey'\n"> /root/.ddtraining.sh
chmod +x /root/webprovision.sh
echo "running web provision" > status.txt
# /root/webprovision.sh
echo "done" > status.txt