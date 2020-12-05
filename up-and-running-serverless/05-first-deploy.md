Create a variable called STAGE and set it to the first letter of your first name followed by your last name. We will use this to avoid collisions, as we are sharing a single AWS account.

```bash
# use the first letter of your first name followed by your last name
STAGE="jsmith" 
```

Then, deploy with the following command.

```bash
sls deploy --stage $STAGE
```

Now, it's time to test our new function.

Use a command like `wget -O testimage.jpg https://i.imgflip.com/w7qv5.jpg` to download your choice of jpg from the web into your environment.

Then run this script to test posting the image to our service:

```bash
./upload.sh "$STAGE" testimage.jpg
```

Give S3 a few seconds to process, and then open up the URL printed out by the upload script.
