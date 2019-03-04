* Return to the Metrics Summary and find the training.hosts.started metric.
If it's been more than an hour since you started the Vagrant boxes, this metric will not show. Either restart the Vagrant boxes or change the time dropdown to 1 day or 1 week. You can restart the Vagrant boxes with the following commands:
vagrant halt
vagrant destroy -f
vagrant up
You can also force the metric to appear by running the same command that is in the provision script. First login to one of the virtual machines:
vagrant ssh web1
Then run the command to create the metric:
echo -n "training.hosts.started:1|c|#shell" >/dev/udp/localhost/8125

* Click on the metric to see the details pane pop out.

* Click the pencil icon next to Metadata.

* Enter a good description for this metric.
This metric is added to Datadog when you start the Vagrant boxes. Adding a description to any custom metrics is a good idea to ensure that everyone knows what the metric describes. Notice that you can edit the description, the units, the type, and the interval. These details will be available to anyone else in your organization. 



