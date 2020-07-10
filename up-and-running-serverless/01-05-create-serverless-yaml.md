Now we'll create the YAML config file for our serverless project.

Open your editor and create a new file called `serverless.yml`. Then copy the YAML content below into your editor:

```yaml
service: dash-serverless-workshop

provider:
  name: aws
  stage: ${opt:stage}
  imageBucketName: dash-serverless-workshop-images-${opt:stage}
  environment:
    BUCKET_NAME: ${self:provider.imageBucketName}
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
      - s3:
          bucket: ${self:provider.imageBucketName}
          event: s3:ObjectRemoved:*
```

This is creating the S3 bucket and Lambda function that we're going to be using. As a handler it uses the `handler` function that we just wrote in `create-image-upload-url.js`.

[Serverless.yml reference](https://serverless.com/framework/docs/providers/aws/guide/serverless.yml/)
