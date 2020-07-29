In this lab we are going to use the fixed version of our site, but it's not started yet. Due to the way we launch the app on this training platform, we need to set some environment variables first that will tell RUM about what this application is.

1.  Let's start by taking a look at the source code for our app. Open `store-frontend-instrumented-fixed/store-front-end/app/views/layouts/application.html.erg` in the IDE.
2.  This is the main wrapper code for the site and we can see the Datadog RUM script being loaded with a couple environment variables. That's all we need to do to the code to get this to work.
3.  Open Datadog and navigate to **UX Monitoring** > **RUM Applications**
4.  We need to create a new application to monitor. Click the **New Application** button.
5.  Enter a name for the application. `Ecommerce App` is a fine name.
6.  Click the **Generate Client Token** button.
7.  Scroll down till you see the Javascript to include. There are two versions: NPM and Bundle. Click the **Bundle** tab.
8.  Leave this window open because we are going to need it.
9.  Copy this text and then paste it to the terminal. Don't press return just yet.
   `DD_CLIENT_TOKEN=CHANGEME DD_APPLICATION_ID=CHANGEME2`{{copy}}
10. Go back to the RUM page and copy the ClientToken value. Don't copy the key and value, just the value with no quotes.
11. Replace the first CHANGEME on the command line with that client token. 
12. Repeat the process with the application ID.
13. Now copy this text and paste it to the end of the line thats already there, making sure there is a space between the two pastes. Not a carriage return, just a single space. 
    `POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f /root/ecommworkshop/docker-compose-files/docker-compose.yaml up -d`{{copy}}
14. Press return and we should see that Docker is starting.
15. Open the Store Dog web site. Navigate around, do a search, maybe a few other things. 
16. Go back to the RUM page and click the **Back to the Application List** button at the bottom.
17. 