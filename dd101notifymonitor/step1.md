* Open the first terminal tab run the `light`{{execute T1}} command. 
* Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a> and navigate to the New Monitor page.
* Create a new **Outlier** monitor.
* For the metric, enter `apache.net.hits` and select **host** for the **(everything)** textbox. 
* Enter a relevant title and description in the **Say what's happening** section. 
* For description, type the `@` symbol and choose the name you entered when you created your account. Click **Save**.
* Open the terminal tab for Host04 and stop **apache** by running the command `apachectl stop`{{execute T4}}
* Navigate to the Triggered Monitors page.<br>
  *Within a few seconds you should see your Outlier monitor firing. You will also be getting an email.*
* Click on the name of the Outlier monitor you created. <br>
  *Scroll through the page to discover what information is displayed.*
* Click the **Edit** tab at the top to edit the monitor. 
* Scroll down to **Set alert conditions** and change the algorithm used and the various parameters. 
* Click the question mark to the right of this to see an explanation of the choices.
* Navigate to the Event Stream. <br>
  *You should see your Outlier monitor in the stream.*
* Navigate to the Settings page (you can find it at the icon on the bottom of the sidebar) then click on preferences.<br>
  *If you would prefer to only receive notifications like this in the product and not in your email, you can configure which notifications you want to receive.*

  **When you are finished, run `grademe`{{execute}} in the terminal. If you have earned the full score, click the **Continue** button to end the scenario.**
