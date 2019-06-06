# Installing the Agent
To start gathering logs from our system, we can use any log shipper, but in order to benefit from the advantages displayed in the previous exercises of this workshop, we strongly advise you to use the Datadog Agent. To get the Datadog agent:

1. Navigate to the <a href="https://app.datadoghq.com/account/settings#agent/ubuntu" target="_datadog">Agent Installation instructions</a> page for Ubuntu.
2. Copy the **easy one-step install** command line and run it in the terminal to the right.
3. Once installed, you should see this in your shell:
  
<pre><code>Your Agent is running and functioning properly. It will continue to run in the
background and submit metrics to Datadog.

If you ever want to stop the Agent, run:
  sudo systemctl stop datadog-agent

And to run it again run:
  sudo systemctl start datadog-agent
</code></pre>


This means that the Datadog agent is up and running and is ready to be configured.

Gathering Data
We have 2 types of logs: full text and JSON. We need to configure our agent accordingly: (Log collection documentation)

Enable log collection in /etc/datadog-agent/datadog.yaml by setting logs_enabled: true. This file is not synchronized from the host and you will need to use elevated priviledges (sudo) to edit.
Create a  workshop.d folder in the /etc/datadog-agent/conf.d/ folder
sudo mkdir /etc/datadog-agent/conf.d/workshop.d
Create a file/etc/datadog-agent/conf.d/workshop.d/conf.yaml in that directory and add the following content:
logs:

  - type: file
    path: /vagrant/text_log.log
    service: text_log
    source: dummy_app
    sourcecategory: custom
    tags: workshop:exercise_2, type:text_log

  - type: file
    path: /vagrant/json_log.log
    service: json_log
    source: dummy_app
    sourcecategory: custom
    tags: workshop:exercise_2, type:json_log

  - type: file
    path: /var/log/datadog/*.log
    service: datadog-agent
    source: syslog
    sourcecategory: agent
    tags: workshop:exercise_2, type:datadog-agent
Restart your agent:
sudo systemctl restart datadog-agent
Check if everything is running smoothly:
sudo datadog-agent status
Go into your Logs and check that your logs are here.
