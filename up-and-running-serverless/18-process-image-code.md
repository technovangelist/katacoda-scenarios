Next let's add the implementation for the process image Lambda. Create a new file called
`process-image.js` and add the following code:

```js
const AWS = require("aws-sdk");
const Jimp = require("jimp");

module.exports.handler = async (event, context, callback) => {
  const s3 = new AWS.S3();
  // iterates through every incoming event sent from S3, and processes
  // asynchronously.
  const records = event.Records;
  const promises = records.map(record => processImage(record, s3));

  // Wait until all the processed images are sent to S3
  await Promise.all(promises);
};

async function processImage(record, s3) {
  const s3Record = record.s3;
  const bucket = s3Record.bucket.arn.split(":::")[1];
  const key = s3Record.object.key;
  const stage = key.split("/")[0];
  const id = key.split("/")[2];

  console.log(`Reading file ${key} with id ${id} from bucket ${bucket}`);

  const result = await s3.getObject({ Bucket: bucket, Key: key }).promise();
  const jmp = await Jimp.read(result.Body);

  console.log("Processing file");

  // Make a 256 x 256px greyscale image in JPEG format
  const image = await jmp
    .cover(256, 256)
    .greyscale()
    .getBufferAsync(Jimp.MIME_JPEG);

  console.log("Uploading file to s3");
  await s3
    .putObject({
      Bucket: bucket,
      ACL: "public-read",
      Key: `${stage}/processed/${id}`,
      Body: image,
      ContentType: Jimp.MIME_JPEG
    })
    .promise();
}
```{{copy}}
