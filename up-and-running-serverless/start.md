## The Problem

Writing an image uploader for your website can be deceptively difficult. How do you deal with oversized files, or a user sending a malicious payload? And just as importantly, how do you monitor an image uploader?

## Serverless Soltuion

Our solution is going to use three simple parts:

    * create-image-upload-url: A lambda which generates a presigned url that posts an image to s3
    * dash-serverless-workshop-images: An s3 bucket which holds our images, in with a folder to quarantine unprocessed images
    * process-image: A lambda triggered by s3, which resizes/encodes our images, then puts them back in a processed folder
