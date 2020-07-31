Now that we have a better logging format, let's run the attack script.

```
docker run -d --network=securityworkshop_default attacker
```{{execute}}

Navigate to the Datadog [Log Explorer](https://app.datadoghq.com/logs) and review the logs.

Try to debug the application and understand why authentications are failing.
