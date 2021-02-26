# Installing the Agent
To start gathering logs from our system, we can use any log shipper, but in order to benefit from the advantages displayed in the previous exercises of this workshop, we strongly advise you to use the Datadog Agent. To get the Datadog agent:

1. Navigate to the <a href="https://app.datadoghq.com/account/settings#agent/ubuntu" target="_datadog">Agent Installation instructions</a> page for Ubuntu.
2. Copy the **easy one-step install** command line and run it in the terminal to the right.
   *If it looks like the terminal isn't ready for input, press Enter in the terminal.*
3. Once installed, you should see this in your shell:
  
<pre><code>Your Agent is running and functioning properly. It will continue to run in the
background and submit metrics to Datadog.

If you ever want to stop the Agent, run:
  sudo systemctl stop datadog-agent

And to run it again run:
  sudo systemctl start datadog-agent
</code></pre>

This means that the Datadog agent is up and running and is ready to be configured.

