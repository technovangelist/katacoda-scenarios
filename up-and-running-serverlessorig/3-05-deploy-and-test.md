Let's deploy our functions again.

```
sls deploy --stage your-stage-name
```

Now, it's time to test our new function

```bash
./upload.sh "your-stage-name" testimage.jpg
```

Give s3 a few seconds to process, and then open up the url printed out by the upload script.
