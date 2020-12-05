#!/bin/bash
cd ~/workshop

if [ -z ${STAGE+x} ]; then echo Enter your first initial and last name as one word. So Matt williams would be mwilliams; read STAGE; export STAGE; fi

echo $STAGE

echo Installing Serverless Framework
npm install -g serverless
rm serverless.yml
rm create-image-upload-url.js
rm package.json
echo Creating Serverless.yml file
cat > serverless.yml <<EOL
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
plugins:
  - serverless-plugin-datadog

custom:
  datadog:
    enableXrayTracing: true
    forwarder: arn:aws:lambda:us-east-1:095257436141:function:datadog-ForwarderStack-1AMJ1QJ882CUH-Forwarder-1T13KB0KAFJEB
EOL

echo Creating create-image-upload-url.js file
cat > create-image-upload-url.js <<EOL
const AWS = require("aws-sdk");
const uuid = require("uuid/v4");

const axios = require("axios");
const sendDistributionMetric = require("datadog-lambda-js").sendDistributionMetric;

module.exports.handler = async (event, context) => {
  const s3 = new AWS.S3();
  const bucket = process.env.BUCKET_NAME;
  const stage = process.env.STAGE;

  const id = `${uuid()}.jpg`;
  const key = `${stage}/unprocessed/${id}`;

  // Added logging
  console.info(`Created image id: ${id}`);

  const unprocessedImageUrl = `http://${bucket}.s3.amazonaws.com/${stage}/unprocessed/${id}`;
  const processedImageUrl = `http://${bucket}.s3.amazonaws.com/${stage}/processed/${id}`;

  const signedUrlExpireSeconds = 60 * 3;

  const options = {
    Bucket: bucket,
    Key: key,
    ACL: "public-read",
    Expires: signedUrlExpireSeconds,
    ContentType: "image/jpeg"
  };

  const url = s3.getSignedUrl("putObject", options);

  const unprocessedImageTinyUrlResponse = await axios.get(
    `https://tinyurl.com/api-create.php?url=${unprocessedImageUrl}`
  );
  const processedImageTinyUrlResponse = await axios.get(
    `https://tinyurl.com/api-create.php?url=${processedImageUrl}`
  );

  sendDistributionMetric(
    "create_image_upload_url.request", // Metric name
    1,                                 // Metric value
    `bucket:${bucket}`,                // Metric tag
  );

  return {
    statusCode: 202,
    body: JSON.stringify({
      uploadUrl: url,
      unprocessedImageUrl: unprocessedImageTinyUrlResponse.data,
      processedImageUrl: processedImageTinyUrlResponse.data
    })
  };
};
EOL

echo Creating package.json

cat > package.json <<EOL
{
  "name": "dash-serverless-workshop",
  "version": "1.0.0",
  "description": "Demo Image Processing Pipeline in Lambda",
  "main": "index.js",
  "license": "MIT",
  "dependencies": {
    "aws-sdk": "^2.7",
    "axios": "^0.19.0",
    "uuid": "^3.3.2"
  }
}
EOL
npm install --save-dev serverless-plugin-datadog
npm install

wget -O testimage.jpg https://i.imgflip.com/w7qv5.jpg
./upload.sh "$STAGE" testimage.jpg