1. The first step is to login to <a href="https://app.datadoghq.com" target="_datadog">your Datadog account</a>.
2. Now visit the <a href="https://app.datadoghq.com/account/settings#agent" target="_datadog">Install</a> page and click on Ubuntu. Copy the full, easy one-step install command to install the agent. Paste the command into the terminal and press Enter.
3. It should take about a minute to fully install and when complete you will see something like this:
    ![agentinstalled](assets/agentinstalled.png)
4. To verify that everything is running the way it should, run the status command: `datadog-agent status`{{execute}}.
5. Scroll up and review what is shown. Notice that your API Key is listed and you should recognize the last 4 characters. Also notice that the Logs Agent is not running. Let's change that.
6. Open the `/etc/datadog-agent/datadog.yaml` file in the editor. The `datadog-agent` folder has been symlinked into /root/lab, so open the editor and either navigate to it using the file browser or press CMD/CTRL-P and type `lab/datadog-agent/datadog.yaml` to open it. and find the line with `logs_enabled`. Set it to true and uncomment the line. *The goal here is to scan the file to get a feel for what you can configure here. This line is part of a larger section called **Log Collection Configuration**. You can find the line using the standard Find shortcut in whichever OS you are using*. 
   *Note that the **datadog-agent** directory under **lab** is a symbolic link to **/etc/datadog-agent** so that it shows up in the editor*
7. Run `systemctl restart datadog-agent`{{execute}} to restart the agent and then `datadog-agent status`{{execute}} to verify the status. 
    *Notice that the section for the Logs Agent no longer says that the **Logs agent is not running**.*
8. If running the **status** command results in an error, you should see the line that the parser got up to. Remember that spacing in a YAML file is very important. All the commented lines start with a hash and a space. So to uncomment, remove the hash and the space after the hash. Removing the hash and the space for logs_enabled moves that to the beginning of the line. 
9.  Using that knowledge, uncomment **logs_config** and **container_collect_all**, changing that last one from false to true.
10. Restart the agent again, and run the status command again.
11. Scroll down and find the corresponding settings for APM. See if you can enable it.
12. When you are done with this section, run the `complete`{{execute}} command and then click the **Continue** button.
