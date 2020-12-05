Now we're going to write our Lambda handler code.
Create another file called `create-image-upload-url.js` with these contents::

```js
const AWSXRay = require("aws-xray-sdk");
AWSXRay.captureHTTPsGlobal(require("https"));
var AWS = AWSXRay.captureAWS(require('aws-sdk'));
const uuid = require("uuid/v4");

const axios = require("axios");

module.exports.handler = async (event, context) => {
  const s3 = new AWS.S3();
  const bucket = process.env.BUCKET_NAME;

  const id = `${uuid()}.jpg`;
  const key = `unprocessed/${id}`;
  const publicUrl = `http://${bucket}.s3.amazonaws.com/processed/${id}`;

  const signedUrlExpireSeconds = 60 * 3;

  const options = {
    Bucket: bucket,
    Key: key,
    ACL: "public-read",
    Expires: signedUrlExpireSeconds,
    ContentType: "image/jpeg"
  };

  const url = s3.getSignedUrl("putObject", options);

  response = await axios.get(
    `https://tinyurl.com/api-create.php?url=${publicUrl}`
  );

  return {
    statusCode: 202,
    body: JSON.stringify({
      uploadUrl: url,
      publicUrl: response.data
    })
  };
};
```

You'll notice that we're connecting to an S3 bucket that we haven't created yet using an environment variable that we haven't set yet. We'll do both of these with the `serverless.yml` in the next step.
