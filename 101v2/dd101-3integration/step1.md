In this section we are setting up the integrations for Redis and Nginx. They are being installed in the background as you start. Installing an integration is a two step process. First turn on the check, then in the Datadog UI, enable the integration tile. When you see the message in the terminal saying Redis and Nginx are installed, start the process below.

1. First we need to install the Datadog Agent. You can do so by running this command:

    `DD_AGENT_MAJOR_VERSION=7 bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"`{{execute}}

    This is the same command you grabbed from Datadog in the previous section, minus the API key. Your API key is already set as an environment variable in your Training Lab terminals.

2. Enable Log collection in the `datadog/datadog.yaml`{{open}} file. Either click on the link, or refresh the file explorer view and click on the file there. 
3. Restart the Datadog Agent: `systemctl restart datadog-agent`{{execute}}
4. Run the Status command we used in the last section: `datadog-agent status`{{execute}}. Scroll up till you get to the section for the Collector. Now scroll down to see all the checks that are enabled.
5. Open the **datadog** folder and then expand the **conf.d** folder. Notice that there is a folder for each of the integrations that we support.

    _The datadog folder is a symbolic link to /etc/datadog-agent. This allows us to see its contents in the editor's file browser._

6. Expand the folder called **redisdb.d**. The first step is to rename the **conf.yaml.example** file to **conf.yaml**. This is easiest using the following these commands: 

    `mv /etc/datadog-agent/conf.d/redisdb.d/conf.yaml.example /etc/datadog-agent/conf.d/redisdb.d/conf.yaml`{{execute}}

    You may need to hit that same refresh button again to see the new file name.
7. Take a look at the options in the YAML file: `datadog/conf.d/redisdb.d/conf.yaml`{{open}}. Notice that its looking at localhost on port 6379 for data about Redis. This is the default port. 
8. Restart the Datadog Agent. Give the system a few seconds to update, then run the status command. Scroll back up to the Collector section. Do you see a block about Redis (`redisdb`) metrics being collected?
9. Try enabling the logs as well. You will have take a look at the /var/log/redis directory in the terminal to find the file name, and then change the setting in the integration's yaml file. Restart `datadog-agent` and run `datadog-agent status` to ensure that `redisdb` is listed under Logs Agent.
10. Finally try to enable the Nginx integration. Rename the nginx example file:

    `mv /etc/datadog-agent/conf.d/nginx.d/conf.yaml.example /etc/datadog-agent/conf.d/nginx.d/conf.yaml`{{execute}}

    Then open the file: `datadog/conf.d/nginx.d/conf.yaml`{{open}}. If the file doesn't open, click the refresh button at the top and then click on the file in the file explorer view. You will have to update URL that the agent will use to check nginx's status. You can find the configuration for the nginx server at nginx/sites-enabled/default between lines 16 and 24. If you run into trouble, check out the port in the `nginx_status_url`. You can run `curl <url>` to see if the URL you choose works. If you still have problems, try out the status and restart options we looked at above. 
