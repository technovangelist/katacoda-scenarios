1. In the **Terminal 2** tab, take a look at the **docker-compose.yml** file. 
   
   `more docker-compose.yml`{{execute T2}}
   *Notices that port 10520 is being exposed on the localhost as port 10520*
2. Press **q** to quit the `more` command.
3. Now telnet to that port on localhost:

   `telnet localhost 10520`{{execute T2}}

   *Anything you type at the prompt will be sent to the platform when you press Enter. It's not sent immediately but it should appear in the Log Explorer viewer within a minute.*
4. Type the following message and press Enter:

   `Error - connection refused`{{execute T2}}
5. Open the Log Explorer and look out for the new log line to appear.
   ![Defaults to INFO](/technovangelist/scenarios/logsparse1/assets/defaultsinfo.png)

   *Without updating severity, it defaults to INFO*

   *What is the status of your log message in the platform right now? You can see status at the top of the log message once you click on it. It shows as **Info** whereas you would have expected to have this as an **Error**. To change this we will need to have specific processing rules to extract the severity and the error message.*
6. Navigate to Pipelines and create a new Pipeline. Type service:testtcp for Filter and set the name to Getting Started with Pipelines.
   ![New Pipeline](/technovangelist/scenarios/logsparse1/assets/newpipeline.png)
7. Create a new processor in that pipeline. We can use the Grok Parser for this. Set the **Test against a sample** text box. For the rule, enter:
   `myrule %{word:error.level} - %{data:error.message}`
   
   *You can see the extraction below.*
8. Enter a name and click **Save**.
9. Next we need a Status remapper to remap the value of the "level" attribute to the global log severity. Set the **Status attribute** textbox to `error.level`. Click **Save**.
10. Send the `Error - connection refused`{{execute T2}} line again.
11. Navigate to the Log Explorer and search for **service:testtcp**.
    
    *Notice that your old logs are not impacted. All the processors are applied at ingestion so it does not impact already existing logs. This is very important! You cannot make a modification to an existing log.*
12. To see that it works even for JSON formatted logs, send the following line from telnet:
    `{"error.level":"warning","var1": 10,"error.message":"I told you it would work"}`{{execute T2}}
    ![JSON logs](/technovangelist/scenarios/logsparse1/assets/jsonlogs.png)
    
    *If it doesn't seem to work, make sure that the log you sent has the correct JSON format. Sometimes copy and paste can introduce 'smart quotes' that aren't recognized by the JSON parser. You can try verifying the JSON with https://jsonlint.com/.*

Now that you have created a simple pipeline, let's move on to a few others that you can try on your own.

