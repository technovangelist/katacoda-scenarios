Let's switch over to using docker-compose.

1.  Open the docker-compose.yaml file above
2.  Run `docker-compose up -d`{{execute}}.
3.  Run the datadog info command `docker-compose exec datadog agent status`{{execute}}. How many redis instances are being monitored?
4.  Modify the backendredis service to show the following:

    <pre><code class=yaml>backendredis:
        build: .
        networks:
          - main
        labels:
          com.datadoghq.ad.check_names: '["redisdb"]'
          com.datadoghq.ad.init_configs: '[{}]'
          com.datadoghq.ad.instances: '[{"host":"%%host%%", "port": "%%port%%"}]'
    </code></pre>

5.  Run `docker-compose up -d`{{execute}} again. 
6.  Run the Datadog Agent Info command again, how many instances are being monitored?
