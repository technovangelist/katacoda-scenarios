In this section we are setting up the integrations for Redis and Nginx. They are being installed in the background as you start. Installing an integration is a two step process. First turn on the check, then in the Datadog UI, enable the integration tile. When you see the message in the terminal saying Redis and Nginx are installed, start the process below.

1. First we need to install the Datadog Agent. You can do so by running this command: `bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"`{{execute}}.     This is the same command you grabbed from Datadog in the previous section, minus the API key. The key is already set as an environment variable. 
2. Enable Log collection in the `datadog/datadog.yaml`{{open}} file. Either click on the link, or refresh the file explorer view and click on the file there. 
3. Restart the Datadog Agent: `systemctl restart datadog-agent`{{execute}}
4. Run the Status command we used in the last section: `datadog-agent status`{{execute}}. 
   Scroll up till you get to the section for the Collector. Now scroll down to see all the checks that are enabled.
5. Open the **datadog** folder and then expand the **conf.d** folder. 
   Notice that there is a folder for each of the integrations that we support.
6. Expand the folder called **redis.d**. The first step is to rename the **conf.yaml.example** file to **conf.yaml**. This is easiest using the following command: `mv /etc/datadog-agent/conf.d/redisdb.d/conf.yaml.example /etc/datadog-agent/conf.d/redisdb.d/conf.yaml`{{execute}}. You may need to hit that same refresh button again to see the new file name.
7. Take a look at the options in the YAML file. Notice that its looking at localhost on port 6379 for data about Redis. This is the default port. 
8. Restart the Datadog Agent. Give the system a few seconds to update, then run the status command. 
   Scroll back up to the Collector section. Do you see a block about Redis metrics being collected?
9. Try enabling the logs as well. You will have take a look at the /var/log/redis directory to find the file name and change the setting in the integration's yaml file. 
10. Finally try to enable the Nginx integration. If you run into trouble, check out the port in the nginx_status_url. You can run `curl <url>` to see if the url you choose works.
