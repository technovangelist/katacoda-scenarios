1.  Open the first terminal tab, type CTRL-C to stop the `heavy` script and run the `light`{{execute T1}} script.
1.  Navigate to the New Monitor page in Datadog.
1.  Create a new **Outlier** monitor. This monitor automatically detects unusual metric patterns.
1.  For the metric, enter `apache.net.hits` and select **host** for the **(everything)** field.
1.  In the **Say what's happening** section, type "Anomaly Detected".
1.  In the monitor message, type the `@` symbol and select in your account user. This will auto-fill your Datadog account email address. Click **Save**.
1.  Open the terminal tab for web2 and stop **apache** by running the command `apachectl stop`{{execute T2}}
    _If you get an error about apachctl not being installed, run `ssh web2`{{execute T2}} and then the `apachectl stop` command._
1.  Navigate to the Triggered Monitors page.<br>
    _Within a minute or so you should see your Outlier monitor firing. You will also receive an email._
1.  Click on the name of the Outlier monitor you created. <br>
    _Scroll through the page to discover what information is displayed._
1.  Click the gear icon and then choose **Edit** at the top to edit the monitor.
1.  Scroll down to **Set alert conditions** and change the algorithm used and the various parameters.
1.  Click the question mark to the right of this to see an explanation of the choices. Click **Save**.
1.  Navigate to Events using nav bar. <br>
    _You should see your Outlier monitor in the stream._
1.  Navigate to the Settings page (you can find it at the Account icon in the nav bar) then click on **Preferences**.<br>
    _If you would prefer to only receive notifications like this in the product and not in your email, you can configure your preference under **Email me the following Notifications**._
1.  When you are done with this section, switch to the first terminal and type CTRL-C to stop the `light` script. Then run `grademe`{{execute}} to indicate that you are done. Then click the **Continue** button.
