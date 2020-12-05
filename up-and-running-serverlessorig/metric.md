Import `datadog` and `sendDistributionMetric`.

```js
const datadog = require("datadog-lambda-js").datadog;
const sendDistributionMetric = require("datadog-lambda-js").sendDistributionMetric;
```

Wrap the handler with `datadog` and send a metric.

```js
module.exports.handler = datadog(async (event, context, callback) => {
    // ADD A METRIC
    sendDistributionMetric(
        "create_image_upload_url.request", // Metric name
        1,                                 // Metric value
        `bucket:${bucket}`,                // Metric tag
    );

    return {
        statusCode: 202,
        body: JSON.stringify({
            uploadUrl: url,
            publicUrl: response.data
        })
    };
});
```
