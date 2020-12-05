We are going to build an image processing service with a serverless architecture.

The service will consist of two Lambda functions:
- A Lambda that gets a presigned URL from Amazon S3 that allows us to upload an image
- A Lambda that processes an image by making it square and grayscale

First we will implement the image upload URL Lambda. Then we will add the image processing Lambda.