* Click on the third tab on the right to open the terminal on the first web server.
* Navigate to the <code>/etc/datadog-agent</code> directory.
  `cd /etc/datadog-agent`{{execute T3}}<br>
  *This is where you can find the configuration files for the Datadog agent.*
* Take a look at the datadog.yaml file using the following command:
  `sudo less datadog.yaml`{{execute T3}}<br>
  *At the top of the file you can see that the API Key is configured.*<br>
  *A little further down, tags are configured. You should definitely take advantage of tags to make it easier to find the services you are monitoring.*
* Press the letter `Q`{{execute T3}} to quit <code>less</code> and navigate to the <code>/etc/datadog-agent/conf.d/couchbase.d</code> directory. List the contents of the directory.
  `cd /etc/datadog-agent/conf.d/couchbase.d;ls`{{execute T3}}<br>
  *We are not using couchbase in this environment. Each supported agent-side integration has a directory, a conf.yaml.example file, and sometimes an auto_conf.yaml file. If there were a properly configured conf.yaml file in this directory, we would be monitoring couchbase.*
* Navigate to the <code>/etc/datadog-agent/conf.d/apache.d</code> directory. List the contents of the directory.<br>
  *We are using apache httpd on this virtual machine. We could have customized the configuration further if we wanted, but the defaults are usually good for most users.*
* Look at the contents of **conf.yaml** and **conf.yaml.example**.<br>
  *Notice that we only have to specify the options that we need*
* See if you can identify how the other machines are configured. Each has a tab opened so you can easily take a look.