We can add a Lambda Layer to our Lambda function to collect additional metrics. The easiest way to do this is with Datadog's plugin for the Serverless Framework.

Install the plugin with `npm install --save-dev serverless-plugin-datadog`.

Then update your `serverless.yml` file:

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

plugins:
  - serverless-plugin-datadog

custom:
  datadog:
    enableXrayTracing: true
    forwarder: arn:aws:lambda:us-east-1:095257436141:function:datadog-ForwarderStack-1AMJ1QJ882CUH-Forwarder-1T13KB0KAFJEB
```{{copy}}

[Learn more about Datadog Lambda Layers](https://docs.datadoghq.com/integrations/amazon_lambda/?tab=node#installing-and-using-the-datadog-layer)