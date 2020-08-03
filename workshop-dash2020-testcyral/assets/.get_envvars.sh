until [[ $(curl --silent --output .env --write-out "%{http_code}" -u dash-student d26r8lizeb5ws2.cloudfront.net) -eq 200 ]]
do
  printf "Incorrect password, please try again\n\n"
done

set -a
source .env
set +a

printf "\nSuccess! Configured the following environment variables:\n"
cat .env
printf "\n"

echo "done" >> /opt/.envvarsfinished
