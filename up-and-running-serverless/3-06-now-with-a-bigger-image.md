Now let's try another test case, this time with a different image.

```bash
./upload.sh "your-stage-name" datadoge-large.jpg
```

It looks like the image never shows up in our bucket.

1. Let's go to [datadog](https://app.datadoghq.com/functions) to investigate.
2. Add a filter for your stage name to find your function.
3. Open up your functions page, then click logs.
