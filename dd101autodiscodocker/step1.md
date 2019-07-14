1.  Navigate to the <a href="https://app.datadoghq.com/account/settings#agent/docker" target=_datadog>Agent Installation</a> page in the Datadog application.

2.  Select **Docker** and copy the first command to the terminal to the right.

3.  You now have the Datadog agent running in your training environment.

4.  Run `docker exec -it dd-agent bash`{{execute}} to login to a bash shell on that container.

5.  You can now run any of the Datadog commands you have on Linux. For instance, run `agent status`{{execute}}.

6.  Run `agent`{{execute}} to see the other available commands, or type `exit`{{execute}} to return to your host machine.

7.  Start a Redis container by running the following command: `docker run -d --name ad-redis redis`{{execute}}. This is starting a container based on the image name `redis`.

8.  Run the Datadog Agent Status command `docker exec -it dd-agent agent status`{{execute}}. Also run the Agent's configcheck command `docker exec -it dd-agent agent configcheck`{{execute}}. 

    *Is Redis being monitored? Try waiting a few seconds and try again.*

9.  Kill and remove the containers using the command `docker rm -f $(docker ps -q)`{{execute}}

10. Start the Datadog container again using the same command as before.

11. Open the file called `Dockerfile` in the `redisdocker` directory. Notice that the contents are a single line:
    <pre><code>FROM redis
    </code></pre>

12. Build the new image using the following command: `docker build -t inmemdb docker`{{execute}}

13. Run the redisdocker image using the command: `docker run --name inmemdb -d inmemdb`{{execute}}.

    *The Redis docker container based on our modified image is now running.*

14. Run the Datadog Agent configcheck command again `docker exec -it dd-agent agent configcheck`{{execute}}. 

    *Is the new database being monitored? Why do you think that is?*

15. Kill and remove the containers again using the command `docker rm -f $(docker ps -q)`{{execute}}
