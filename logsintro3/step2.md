# Gathering Data

We have 2 types of logs: **full text** and **JSON**. We need to configure our agent accordingly: (<a href="https://docs.datadoghq.com/logs/log_collection/" target="_datadog">Log collection documentation</a>)

1. Enable log collection in `/etc/datadog-agent/datadog.yaml` by setting `logs_enabled: true`. 
2. Create a  **workshop.d** folder in the `/etc/datadog-agent/conf.d/` folder: `mkdir /etc/datadog-agent/conf.d/workshop.d`{{execute}}
3. Create a file **conf.yaml** in that directory `touch /etc/datadog-agent/conf.d/workshop.d/conf.yaml`{{execute}} and add the following content:

    <pre><code>logs:
      - type: file
        path: /var/log/text_log.log
        service: text_log
        source: dummy_app
        sourcecategory: custom
        tags: workshop:exercise_2, type:text_log

      - type: file
        path: /var/log/json_log.log
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
    </code></pre>

4. Restart your agent:
  `sudo systemctl restart datadog-agent`{{execute}}

5. Check if everything is running smoothly:
  `sudo datadog-agent status`{{execute}}

6. Go into your Logs and check that your logs are here.
