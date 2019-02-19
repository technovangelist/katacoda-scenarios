#!/bin/bash
touch /root/test.txt
printf "This script will download the Training Environment.\033[0m  \n\n"


printf "\033[31mDownloading the Training Environment from Github \033[0m\n"
outputfilename=/root/TrainingEnvironment-$(date +%m%Y%d)
curl -L -J https://github.com/DataDog/TrainingEnvironment/archive/master.zip -o $outputfilename
printf "\033[31mUnzipping the Training Environment \033[0m\n"
unzip -q $outputfilename
mv /root/TrainingEnvironment-master/Datadog101/* /root
rm -rf /root/TrainingEnvironment-master

printf "\033[31mConfiguring... \033[0m\n"
printf "#!/bin/bash\nDD_API_KEY='$apikey'\n"> /root/.ddtraining.sh
