In the last steps, you modified the logging format of the log line. Let’s now cover how this log line is actually processed within Datadog.

Browse to the Datadog [Logs Pipelines](https://app.datadoghq.com/logs/pipelines) configuration.

Review the Flask pipeline which is a custom pipeline which was preconfigured for this workshop. The first step in the pipeline is the Grok Parser which will extract all of the attributes. There is a parsing rule named `audit_logs` which extracts out 3 things
* The log level
* The Log Handler
* All of the key value pairs

You can see how this is much simpler than the grok parsers above which extract the attributes from the HTTP access logs.
