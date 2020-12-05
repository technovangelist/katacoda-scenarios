We can add a custom metric to our Lambda function.

Replace `//placeholder 1: Import senddistributionmetric` in the code with:


```
// Import sendDistributionMetric() from datadog-lambda-js
// This library is provided by the Serverless framework plugin, so we don't have to install it.
const sendDistributionMetric = require("datadog-lambda-js").sendDistributionMetric;
```{{copy}}

Then replace `//placeholder 2: send the metric` with: 

```
  // Send the distribution metric here
  sendDistributionMetric(
    "create_image_upload_url.request", // Metric name
    1,                                 // Metric value
    `bucket:${bucket}`,                // Metric tag
  );
```{{copy}}