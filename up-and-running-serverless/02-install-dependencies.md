Now that the Serverless Framework is set up, let's write our handler code that will be called when our Lambda is invoked.

First create a `package.json` by running `touch ~/workshop/package.json`{{execute}}.

Fill `package.json` with this to specify our NPM dependencies:

```
{
  "name": "dash-serverless-workshop",
  "version": "1.0.0",
  "description": "Demo Image Processing Pipeline in Lambda",
  "main": "index.js",
  "license": "MIT",
  "dependencies": {
    "aws-sdk": "^2.7",
    "axios": "^0.19.0",
    "uuid": "^3.3.2"
  }
}
```{{copy}}

Ensure that you are in the workshop directory (`cd ~/workshop`{{execute}}), and then fetch the dependencies with `npm install`{{execute}}

