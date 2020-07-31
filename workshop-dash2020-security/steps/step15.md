# Defining The Detection Rule Cases

**Define the successful case**

**Trigger:** `unique_failed_authentication > 100 && successful_login > 0`

**Name:** `successful attack`

**Severity:** `HIGH`

**Define the attack attempted  case**

**Trigger:** `unique_failed_authentication > 100`

**Name:** `attempt`

**Severity:** `INFO`


## Additional Resources
* Datadog Documentation on [defining the rule cases](https://docs.datadoghq.com/security_monitoring/detection_rules#define-the-rule-cases).
