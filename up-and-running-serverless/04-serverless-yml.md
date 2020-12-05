Now we'll create the YAML config file for our Serverless project.

Create the serverless.yml file: `touch ~/workshop/serverless.yml`{{execute}}. Then copy the YAML content below into the new file:

```
service: dash-serverless-workshop

provider:
  name: aws
  stage: ${opt:stage}
  deploymentBucket:
    name: dd-serverless-workshop-deployment
  imageBucketName: dd-serverless-workshop-images
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
```{{copy}}

This will create the S3 bucket and Lambda function that we're going to be using. The Lambda function will use the `handler` that we just wrote in `create-image-upload-url.js`.

[Serverless.yml reference](https://serverless.com/framework/docs/providers/aws/guide/serverless.yml/)
