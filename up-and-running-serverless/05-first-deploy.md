In this lab we are all pushing code to the same AWS account. We will keep our code separate by assigning a unique stage to our functions. We can do this by setting an environment variable.

Create an environment variable called STAGE as shown in the example below and set it to the first letter of your first name followed by your last name. 

```bash
# use the first letter of your first name followed by your last name
STAGE="jsmith" 
```

Then, deploy with the following command.

`sls deploy --stage $STAGE`{{execute}}

Now, it's time to test our new function.

Use a command like `wget -O testimage.jpg https://i.imgflip.com/w7qv5.jpg`{{execute}} to download your choice of jpg from the web into your environment.

Then run this script to test posting the image to our service:

`./upload.sh "$STAGE" testimage.jpg`{{execute}}

Give S3 a few seconds to process, and then open up the URL printed out by the upload script.
