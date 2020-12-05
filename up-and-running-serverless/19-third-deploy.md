Let's deploy our functions again.

```
sls deploy --stage $STAGE
```

Now, it's time to test our new function

```bash
./upload.sh "$STAGE" testimage.jpg
```

Give S3 a few seconds to process, and then open up the URL printed out by the upload script.
