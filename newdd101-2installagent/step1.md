1.  The first step is to login to <a href="https://app.datadoghq.com" target="_datadog">your Datadog account</a>.
2.  After logging in, verify that you are in the right account. Visit <a href="https://app.datadoghq.com/account/settings#api" target="_datadog">the API keys section</a>, expand API Keys and identitfy your API key.
Now in the terminal, run the `env`{{execute}} command and look for the API Key environment variable. Verify that they are the same.
    *Note: API and APP keys are different.*
3.  Now visit the <a href="https://app.datadoghq.com/account/settings#agent" target="_datadog">Install</a> page and click on Ubuntu. Copy the full, easy one-step install command to install the agent. Paste the command into the terminal and press enter.
4.  It should take about a minute to fully install and when complete you will see something like this:
    Your Agent is running and functioning properly. It will continue to run in the
    background and submit metrics to Datadog.
    If you ever want to stop the Agent, run:
        systemctl stop datadog-agent
    And to run it again run:
        systemctl start datadog-agent
5.  To verify that everything is running the way it should, run the status command: `datadog-agent status`{{execute}}.
