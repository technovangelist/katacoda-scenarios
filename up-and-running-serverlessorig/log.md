Let's log the randomly generated image id in `create-image-upload-url.js`.


```js
const s3 = new AWS.S3();
const bucket = process.env.BUCKET_NAME;

const id = `${uuid()}.jpg`;
const key = `unprocessed/${id}`;
const publicUrl = `http://${bucket}.s3.amazonaws.com/processed/${id}`;

// ADD THIS LINE
console.info(`Created image id: ${id}`);
```
