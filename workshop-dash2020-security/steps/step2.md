Let's first run the attack script to simulate an attack on the environment.
```
docker run -d --network=securityworkshop_default attacker
```{{execute}}

This script will take about a minute or two to trigger the monitor.

Navigate to the [Triggered Monitors](https://app.datadoghq.com/monitors/triggered) page and see the triggered monitor.

Note: from the triggered monitor you would not necessarily know you are under attack.
You would only know that the number of failed authentications are high.
When investigating this further, let's keep this in mind rather than drawing the conclusion that we are under attack.

Navigate to the Datadog Dashboards [list view](https://app.datadoghq.com/dashboard/lists) and access the “Our Custom Login Dashboard”

Navigate to the Datadog [Log Explorer](https://app.datadoghq.com/logs) and review the logs.

Try to debug the application and understand why authentications are failing.
