1.  Add a **Query Value** widget to the canvas using the same metric: <code>apache.performance.busy_workers</code>. <br>
  *Try out the different options available.*
1.  Click **Save**.
1.  Add a **Heat Map** with the same metric and click **Save**.
2.  Try adding **Distribution**, **Top List**, **Change**, **Scatter Plot** (choose another metric for one of the axes), and **Hostmap** changing the metrics as needed.<br>
  _Which graphs work well for this metric with 3 hosts?_
1.  Click the pencil icon for some of the graphs. Click the plus sign to the right of the metric to see the different functions available.<br>
  _Functions are helpful when you want to adjust the values that are shown. We will work with these soon._
1.  Add another **Timeseries** with the same <code>apache.performance.busy_workers</code> metric.
2.  Now click on the **Metrics** link after **Graph additional** to add another metric line to your graph. 
3.  Add <code>apache.performance.idle_workers</code>.<br>
  *This created a graph with two lines, but sometimes you want a graph with a single line made up of several metrics. We'll see how to do that next.*