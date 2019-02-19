printf "This script will download the Training Environment. It is installed into the current directory:\n\n    $installdir  \n\n
If you want to move this to a different directory, the easiest way is to delete the directory \nand run the command from the Learning Center again.\033[0m  \n\n"


printf "\033[31mDownloading the Training Environment from Github \033[0m\n"
outputfilename=TrainingEnvironment-$(date +%m%Y%d)
curl -L -J https://github.com/DataDog/TrainingEnvironment/archive/master.zip -o $outputfilename
printf "\033[31mUnzipping the Training Environment \033[0m\n"
unzip -q $outputfilename
mv TrainingEnvironment-master/Datadog101/* .
rm -rf TrainingEnvironment-master

printf "\033[31mConfiguring... \033[0m\n"
printf "#!/bin/bash\nDD_API_KEY='$apikey'\n"> .ddtraining.sh
