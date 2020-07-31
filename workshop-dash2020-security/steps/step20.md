# Investigating the Security Signals

Now that you have written the rule, it is time to detect the attack with this newly created rule.  Run attack script

```
docker run -d --network=securityworkshop_default attacker
```{{execute}}

Navigate to the Datadog [Security Explorer](https://app.datadoghq.com/security) and review the Security Signals.
The rules operate in real time so as soon as the logs are sent from the docker container to Datadog and match the rules
based on the configured thresholds, the signals will start appearing in the Security Explorer.

Use the Security Monitoring product to begin investigating the signals.

Use the Security Monitoring Product in conjunction with the Log Management product to try and find which users were compromised as part of this attack.
