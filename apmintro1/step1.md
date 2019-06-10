# Getting started with APM
1. The docker environment is starting to run with the command `./start00`.
  
  *<strong>start00</strong> starts running the **docker-compose.yml** file in the step00 directory. This docker-compose file defines the Datadog agent and a single web container configured to execute `first.py`. There is nothing in that file yet, you will be filling it out in this session.*

  Now let's start shipping our first traces. For our example, we'll start with the dd-trace-py library. We need to install the library in the web container so we will preface the pip command with docker-compose exec:

2. In a second terminal window, navigate to the `step00` directory. Then install the trace library for Python using the following command:
  `docker-compose exec web pip3 install 'ddtrace==0.12.0'`{{execute T2}}

