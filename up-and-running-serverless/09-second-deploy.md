Deploy with the command we used earlier, again replacing `stage-name` with the name you used in the last deploy.

```bash
sls deploy --stage $STAGE
```

And again run this script to test posting the image to our service:

```bash
./upload.sh "$STAGE" testimage.jpg
```

If there was a problem with your environment, you can catch up to where we are by running `. catchup9.sh`{{execute}}
