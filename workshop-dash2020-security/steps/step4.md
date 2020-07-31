Datadog’s Log Monitoring product supports multiple types of [processors](https://docs.datadoghq.com/logs/processing/processors). One of those processors is the [Grok Parser](https://docs.datadoghq.com/logs/processing/processors/?tab=ui#grok-parser).
“Groking” logs can be very cumbersome. Since you are in control of your application logs, let’s make it easy on yourself.
By using a structured format such as the log line
`key=value usr.id=justin.massey`

You can easily parse these key value pairs with the [keyvalue](https://docs.datadoghq.com/logs/processing/parsing/?tab=matcher#key-value-or-logfmt) processor. This processor will extract the log to the following JSON

```
{
  "key": "value",
  "usr": {
    "id": "justin.massey"
  }
}
```

This will save you many hours writing and debugging grok parsers.
