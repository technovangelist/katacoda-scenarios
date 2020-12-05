We can add a Lambda Layer to our Lambda function to collect additional metrics. The easiest way to do this is with Datadog's plugin for the Serverless Framework.

Install the plugin with `npm install --save-dev serverless-plugin-datadog`{{execute}}.

Then add the following code to the end of your `serverless.yml` file (plugins and custom should be at the same indent level as service, provider, and functions):

```yaml
plugins:
  - serverless-plugin-datadog

custom:
  datadog:
    enableXrayTracing: true
    forwarder: arn:aws:lambda:us-east-1:095257436141:function:datadog-ForwarderStack-1AMJ1QJ882CUH-Forwarder-1T13KB0KAFJEB
```{{copy}}

[Learn more about Datadog Lambda Layers](https://docs.datadoghq.com/integrations/amazon_lambda/?tab=node#installing-and-using-the-datadog-layer)