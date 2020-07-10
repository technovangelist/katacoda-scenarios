Next let's add the implementation for the process image lambda. Create a new file called
`process-image.js` and add the following code.

```js
const AWSXRay = require("aws-xray-sdk");
AWSXRay.captureHTTPsGlobal(require("https"));
var AWS = AWSXRay.captureAWS(require('aws-sdk'));
const datadog = require("datadog-lambda-js").datadog;
const Jimp = require("jimp");

module.exports.handler = datadog(async (event, context, callback) => {
  const s3 = new AWS.S3();
  // iterates through every incomming event sent from s3, and processes
  // asynchronously.
  const records = event.Records;
  const promises = records.map(record => processImage(record, s3));

  // Wait until all the processed images are sent to s3
  await Promise.all(promises);
});

async function processImage(record, s3) {
  const s3Record = record.s3;
  const bucket = s3Record.bucket.arn.split(":::")[1];
  const key = s3Record.object.key;
  const id = key.split("/")[1];

  console.log(`Reading file ${key} with id ${id} from bucket ${bucket}`);

  const result = await s3.getObject({ Bucket: bucket, Key: key }).promise();
  const jmp = await Jimp.read(result.Body);

  console.log("Processing file");

  // Make a 256/256px greyscale image, in jpeg format
  const image = await jmp
    .cover(256, 256)
    .greyscale()
    .getBufferAsync(Jimp.MIME_JPEG);

  console.log("Putting file to s3");
  await s3
    .putObject({
      Bucket: bucket,
      ACL: "public-read",
      Key: `processed/${id}`,
      Body: image,
      ContentType: Jimp.MIME_JPEG
    })
    .promise();
}
```
