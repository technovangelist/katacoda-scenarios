1.  First login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>.
2.  Go to the <a href="https://app.datadoghq.com/event/stream" target="_datadog">Event Stream</a>.<br>
  *From the Event Stream, you can see that your environment has started and that data is being reported. You should see that five Datadog Agents have started: host01, host02, host03, host04, and host05.*
3.  Now go to the <a href="https://app.datadoghq.com/metric/summary" target="_datadog">Metrics Summary page</a>.<br>
  *The Metrics Summary page shows all the metrics being collected in your environment. You should see about 160 metrics.*
4.  Go to the <a href="https://app.datadoghq.com/metric/explorer" target="_datadog">Metrics Explorer</a> and type <code>haproxy</code> in the **graph** textbox.<br>
  *Filtering by haproxy will show all the metrics collected by the HAProxy integration.  Notice that the dropdown has filtered the available metrics to show just the ones with haproxy in the name. Also, note that haproxy is the fourth machine to start in the environment. If you don't see the metrics, you might need to wait a couple minutes for your training environment to launch completely.*
5.  Continue typing <code>br2</code> and then press enter.<br>
  *We want the **haproxy.backend.response.2xx** metric. We don't have to scroll or type the whole name when in the Metrics Explorer. Fuzzy searching works here and the right metric is selected. (This trick doesn't work in the Metrics Summary).*
6.  Click in the textbox for **Over**.<br>
  *Almost all of these are all the tags that have been assigned to these metrics. You could look in the setup files for your training environment and see that only the role:lb tag has been manually assigned. Datadog recognizes various configuration choices and automatically turns them into tags.*
7.  Choose **host** in the **One graph per:** dropdown.<br>
  *We only have a single HAProxy host so this isn't very exciting.*
8.  Remove the HAProxy metric and try typing <code>anh</code> in the **Graph:** textbox.<br>
  *It's another fuzzy search, this time selecting **apache.net.hits**.*
9.  Now choose **host** in the **One graph per:** textbox.<br>
  *You should see 3 graphs shown.*