  
We have to give our lambda permission to launch from an s3 event. Copy the following code to your serverless.yml.

```yml
# serverless.yml

resources:
  Resources:
    # ...
    ProcessImagePermissionS3:
      Type: "AWS::Lambda::Permission"
      Properties:
        FunctionName:
          "Fn::GetAtt":
            - ProcessDashimageLambdaFunction
            - Arn
        Principal: "s3.amazonaws.com"
        Action: "lambda:InvokeFunction"
        SourceAccount:
          Ref: AWS::AccountId
        SourceArn: "arn:aws:s3:::${self:provider.imageBucketName}"
```
