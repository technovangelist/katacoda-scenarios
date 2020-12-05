Let's deploy our functions again.

`sls deploy --stage $STAGE`{{execute}}

Now, it's time to test our new function

`./upload.sh "$STAGE" testimage.jpg`{{execute}}

Give S3 a few seconds to process, and then open up the URL printed out by the upload script.
