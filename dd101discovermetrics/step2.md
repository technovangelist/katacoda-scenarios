1.  Return to the Metrics Summary and find the training.hosts.started metric.<br>
  *If it's been more than an hour since you started the training environment, this metric will not show. You can  force the metric to appear by running the same command that we ran automatically. In the terminal to the right, run: `echo -n "training.hosts.started:1|c|#shell" >/dev/udp/localhost/8125`{{execute}} You can click the command box above to automatically copy and run it in the terminal window.*
2.  Click on the metric to see the details pane pop out.
3.  Click the pencil icon next to **Metadata**.
4.  Enter a good description for this metric.<br>
  *This metric is added to Datadog when you start the Vagrant boxes. Adding a description to any custom metrics is a good idea to ensure that everyone knows what the metric describes. Notice that you can edit the description, the units, the type, and the interval. These details will be available to anyone else in your organization.*


**When you are finished, run `grademe`{{execute}} in the terminal. If you have earned the full score, click the **Continue** button to end the scenario.**
