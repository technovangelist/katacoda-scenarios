# Installing the Agent
To start gathering logs from our system, we can use any log shipper, but in order to benefit from the advantages displayed in the previous exercises of this workshop, we strongly advise you to use the Datadog Agent. To get the Datadog agent:

Install the Datadog Agent on your Vagrant box:

./setupagent.sh
This shell script simply runs the standard install process with your training environment API key pre-populated. 

Once installed, you should see this in your shell:

Your Agent is running and functioning properly. It will continue to run in the
background and submit metrics to Datadog.

If you ever want to stop the Agent, run:

    sudo systemctl stop datadog-agent

And to run it again run:

    sudo systemctl start datadog-agent
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
