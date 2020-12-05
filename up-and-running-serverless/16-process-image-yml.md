Now we are going to add a second function. Replace your `serverless.yml` with the following:

```yaml
service: dash-serverless-workshop

provider:
  name: aws
  stage: ${opt:stage}
  deploymentBucket:
    name: dash-serverless-workshop-deployment
  imageBucketName: dash-serverless-workshop-images
  environment:
    BUCKET_NAME: ${self:provider.imageBucketName}
    STAGE: ${self:provider.stage}
  iamRoleStatements:
    - Effect: "Allow"
      Action:
        - "s3:PutObject"
        - "s3:PutObjectAcl"
        - "s3:GetObject"
      Resource: "arn:aws:s3:::${self:provider.imageBucketName}/*"

functions:
  create-image-upload-url:
    runtime: nodejs10.x
    name: create-upload-url-${self:provider.stage}
    handler: create-image-upload-url.handler
    events:
      - http:
          path: images/uploads
          method: post
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

plugins:
  - serverless-plugin-datadog

custom:
  datadog:
    forwarder: arn:aws:lambda:us-east-1:095257436141:function:datadog-ForwarderStack-1AMJ1QJ882CUH-Forwarder-1T13KB0KAFJEB
```{{copy}}

`process-image` will be invoked when a new file is uploaded to our S3 bucket.
