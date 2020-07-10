Now that the serverless framework is set up, let's write our handler code that will be called when our Lambda is invoked.

First use your KataCoda editor to create a `package.json` file like this:
![how-to-create-katacode-file](https://d2ddoduugvun08.cloudfront.net/items/0J0v0q3S2J120l1Y1v3G/Image%202019-07-15%20at%204.24.40%20PM.png)

Fill `package.json` with this to specify our NPM dependencies:

```json
{
  "name": "dash-serverless-workshop",
  "version": "1.0.0",
  "description": "Demo Image Processing Pipeline in Lambda",
  "main": "index.js",
  "license": "MIT",
  "dependencies": {
    "aws-xray-sdk": "2.3.3",
    "axios": "0.19.0",
    "uuid": "3.3.2"
  }
}
```

Now run `npm install` to fetch our dependencies.
