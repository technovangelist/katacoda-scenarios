Now that the Kubernetes audit logs are coming in to Datadog, let's process them so we can get additional value out of them. 

1. Navigate to Logs > Configuration. Click the **New Pipeline** button. Enter `Source:kubernetes.audit` in the **Filter** textbox and name the pipeline `Kubernetes Audit`.
