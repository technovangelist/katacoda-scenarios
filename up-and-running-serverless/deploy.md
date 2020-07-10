Deploy with the following command.

```bash
sls deploy --stage <stage-name>
```

NOTE: Because we are deploying to a shared environment, please update `<stage-name>` to something unique, e.g., your full name, say `john-smith` to avoid collisions.

Now, it's time to test our new function.

Use a command like `wget -O testimage.jpg https://i.imgflip.com/w7qv5.jpg` to download your choice of jpg from the web into your environment.

Then run this script to test posting the image to our service:

```bash
./upload.sh "<stage-name>" testimage.jpg
```

Give s3 a few seconds to process, and then open up the url printed out by the upload script.
