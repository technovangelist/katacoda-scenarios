Now we are going to add a second function. Copy the following to your serverless.yml

```yml
functions:
  # ...
  # COPY BELOW HERE
  process-image:
    runtime: nodejs10.x
    name: process-image-${self:provider.stage}
    handler: process-image.handler
    events: # Lauches event when a jpg file is uploaded to the directory
      - s3:
          bucket: ${self:provider.imageBucketName}
          event: s3:ObjectCreated:*
          rules:
            - prefix: unprocessed/
            - suffix: .jpg
    layers:
      - arn:aws:lambda:us-east-1:464622532012:layer:Datadog-Node10-x:2
```

`process-image` will launch when a new file is uploaded to our s3 bucket.
