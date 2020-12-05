Now we are going to add a second function. Open the `serverless.yml` file in the editor. Notice that there is a single function. Below the create-image-upload-url section and above the plugins block, on line 29 add the following:

```yaml
  process-image:
    runtime: nodejs10.x
    name: process-image-${self:provider.stage}
    handler: process-image.handler
    events: # Emits event when a jpg file is uploaded to the directory
      - s3:
          bucket: ${self:provider.imageBucketName}
          existing: true
          event: s3:ObjectCreated:*
          rules:
            - prefix: ${self:provider.stage}/unprocessed
            - suffix: .jpg

```{{copy}}

Then remove the `enableXrayTracing: true` line near the bottom of the file.

`process-image` will be invoked when a new file is uploaded to our S3 bucket.
