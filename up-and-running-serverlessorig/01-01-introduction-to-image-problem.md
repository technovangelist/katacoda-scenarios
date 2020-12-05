We've designed a new app where a major component is allowing users to upload images. To take advantage of the benefits of serverless we've decided to implement the image uploading service using Lambda.

# Getting an upload URL

We're going to store our images in S3, and will use [pre-signed URLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/PresignedUrlUploadObject.html). This involves sending a request to S3, which will give us a URL that we have a few minutes to POST data to.

# Uploading to S3

We'll POST out image to this signed URL in order to upload it to S3.

# Processing the image

First we're going to make the service very simple with no processing.

Then, we'll add features to compress the image, make it a square, make it grayscale, and upload the result to a public S3 bucket.