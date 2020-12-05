Browse to [Log Analytics](https://app.datadoghq.com/logs/analytics) under Logs > Analytics.

1. Increase the time interval to one hour.
1. Set Group By to `Function Name (functionname)`.
1. Select the `Timeseries` or `Top List` view.

This will show you graphs of logs per Lambda function. 

Bonus:

Refine this search to only Error logs using the filter on the left, or with the search bar.