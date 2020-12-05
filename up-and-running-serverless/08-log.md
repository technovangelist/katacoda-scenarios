Let's log the randomly generated image id in `create-image-upload-url.js`.

Replace the line `//placeholder 3: Log the image id` in the Lambda function's code with the following:


```
  // Added logging
  console.info(`Created image id: ${id}`);

```{{copy}}
