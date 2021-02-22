1.  Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>.
1.  Navigate to <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">Dashboards</a> and create a new Dashboard.
1.  Enter <code>First Test</code> for the name and choose **New Timeboard**.
1.  Click "Add graph" and drag a **Notes & Links** widget from the widget selector to the dotted square on the canvas. This will open a widget editor where you can add a description for this dashboard. Click **Done** to close the editor. 
1.  Drag a **Timeseries** widget to the dotted square on the canvas.
1.  In the metric widget editor, find the **Graph your data** section. In the text field next to Metric, select <code>apache.performance.busy_workers</code>. <br>
    _Click the **(everywhere)** and **(everything)** fields to see their possible values. What do these values mean? You can learn more about filtering in the <a href="https://docs.datadoghq.com/dashboards/querying/#choose-the-metric-to-graph" target="_datadog">Querying</a> documentation._
1.  Select <code>host</code> in the **(everything)** textbox.
1.  Try out the different **Display** types (Lines, Area, Bar).<br>
    _What differences do you see in these options? Can you identify when is a good time to use each?_
1.  Click **Save** to add the graph to the dashboard.
