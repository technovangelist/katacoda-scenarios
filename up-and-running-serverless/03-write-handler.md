Now we're going to write our Lambda handler code.
Create another file called `create-image-upload-url.js` with these contents::

```
const AWS = require("aws-sdk");
const uuid = require("uuid/v4");

const axios = require("axios");

module.exports.handler = async (event, context) => {
  const s3 = new AWS.S3();
  const bucket = process.env.BUCKET_NAME;
  const stage = process.env.STAGE;

  const id = `${uuid()}.jpg`;
  const key = `${stage}/unprocessed/${id}`;

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

  return {
    statusCode: 202,
    body: JSON.stringify({
      uploadUrl: url,
      unprocessedImageUrl: unprocessedImageTinyUrlResponse.data,
      processedImageUrl: processedImageTinyUrlResponse.data
    })
  };
};
```{{copy}}

You'll notice that we're connecting to an S3 bucket that we haven't created yet using an environment variable that we haven't set yet. We'll do both of these with the `serverless.yml` in the next step.
