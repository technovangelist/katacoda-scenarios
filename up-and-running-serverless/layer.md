Add the following Datadog Lambda layer to our Lambda function.

```yaml
functions:
  create-image-upload-url:
    layers:
      - arn:aws:lambda:us-east-1:464622532012:layer:Datadog-Node10-x:2
```

Set the following environment variables:

- DD_FLUSH_TO_LOG

```yaml
    environment:
        DD_FLUSH_TO_LOG: True
```

[Learn more about Datadog Lambda layers](https://docs.datadoghq.com/integrations/amazon_lambda/?tab=node#installing-and-using-the-datadog-layer)