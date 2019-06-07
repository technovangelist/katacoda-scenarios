In this hands-on section, we will start using APM. By the end of the section, you will see how easy it is to work with Datadog APM.

To use this section you should have two terminal windows open. One will be running the docker command in step 1, and the other for running other interactive commands. Then you will edit code in whatever your favorite code editor is.

1. Start the docker environment by running:
   `./start00`{{execute T1}}
  *<strong>start00</strong> will start running the docker-compose.yml file in the step00 directory. This docker-compose file defines the Datadog agent and a single web container configured to execute first.py There is nothing in that file yet, you will be filling it out in this session.*

Now let's start shipping our first traces. For our example, we'll start with the dd-trace-py library. We need to install the library in the web container so we will preface the pip command with docker-compose exec:

In a second terminal window, navigate to the step00 directory. Then install the trace library for Python using the following command:

docker-compose exec web pip3 install 'ddtrace==0.12.0'
Configuring the Tracer
Now we have a way to ship our Traces from Python and can jump in and configure a program to be instrumented.

Initialize and configure the Python bindings to ship to our local Docker container by adding the following to first.py in your favorite code editor:

from ddtrace import tracer

tracer.configure(hostname='agent', port='8126')
Note: Normally you won't need to specify the port and hostname as it defaults to port 8126 on the localhost. Since the Agent is running in a different container, we need to specify it here.

When you click save, then switch back to the console where docker-compose is running, you should see that the web container noticed the change. The Agent will mention that it has no tracked services, so we will set that up next.

Creating Our First Span
Update the code in first.py as follows:

from ddtrace import tracer
import time

tracer.configure(hostname='agent', port='8126')

with tracer.trace('first-span', service='first-service') as span:
  time.sleep(1)
The reason we are using sleep is to ensure the tracer has time to flush the trace. This happens asynchronously. If you have a short running application, you will need to ensure there is enough time to flush the trace before the program exits. In most web/API applications, this shouldn't matter, as your program will be long running.

Open your browser to the Datadog APM trace interface. Find the new service in the list of services, along with the trace and span.

APM Service List
APM Service List
If we click on the trace itself, we can see more information, going into the span view. There are two different ways to view our spans. As a flame graph, and as a list.

Span List
Span List
Lists help to quickly narrow down where the majority of time is spent in your traces.

Creating A Child Span
Creating a child is done by creating a tracer span as child_ofthe parent span.

Try that now and see how it changes our spans by modifying the code to first.py:

from ddtrace import tracer
import time

tracer.configure(hostname='agent', port='8126')

with tracer.trace('first-span', service='first-service') as span:
  time.sleep(1)
  with tracer.trace('second-span', service='first-service') as span2:
      span2.set_tag('second-tag', '200')
      time.sleep(1)
      with tracer.trace('third-span') as span3:
          span3.set_tag('third-tag', '300')
          time.sleep(1)
After running this code, we can now go into the Datadog interface, and see how the child span looks:

child span flame
child span flame
If we click into our spans, we can also see the span tags we've set, along with their values.

Tag values
Tag values
Try putting some delays between our spans to see how this affects your timeline. You'll start to get a feel for how spans show different delays of time.

Tracing an HTTP Request
Tracing is most useful when we get to see what's going on in our systems. Let's do two HTTP requests that rely on each other, and see how tracing allows us to visualize the process.

We'll use the requests library which is already installed to the image to do some HTTP GETs on the Github jobs API.

Replace the code in first.py as follows. It will run a request to get a list of the first 50 Python jobs on GitHub, and then try grabbing each job listing's company site

from ddtrace import tracer
import requests

tracer.configure(hostname='agent', port='8126')

with tracer.trace('get-python-jobs', service='get-jobs') as span:
    homepages = []
    res = requests.get('https://jobs.github.com/positions.json?description=python')
    span.set_tag('jobs-count', len(res.json()))
    for result in res.json():
        with tracer.trace('request-site', service='get-jobs') as site_span:
            print('Getting website for %s' % result['company'])
            try:
                res = requests.get(result['company_url'])
                homepages.append(res)
                site_span.set_tag('http.status_code', res.status_code)
                site_span.set_tag('company-site', result['company'])
            except Exception as err:
                print('Unable to get site for %s' % result['company'])
                site_span.set_tag('http.status_code', res.status_code)
                site_span.set_tag('company-site', result['company'])
Notice the new spans that are getting created.

One span encapsulates the job of getting the initial API request, and a new span is created for each request attempting to grab the homepage of a job's company.

Flame Graph vs List View
If we go into the Traces dashboard, we can see the requests, along with their information:



But, we see much more information about slow sites if we click into the list view, and click Exec Time to sort by execution time.


Looking here, we can see which company website is slowest to be fetched, and which is the fastest.

Automatic Instrumentation
Because the requests library is one of the automatic libraries provided by Datadog, we can instrument using that.

Replace the code in first.py as follows:

from ddtrace import tracer, patch

# by default, localhost and 8126, but here as intructional
tracer.configure(hostname='agent', port='8126')

# patch is supposed to be called _before_ importing requests
patch(requests=True)

import requests

@tracer.wrap(name='get-python-jobs', service='get-jobs')
def get_sites():
    homepages = []
    span = tracer.current_span()
    
    res = requests.get('https://jobs.github.com/positions.json?description=python')
    span.set_tag('jobs-count', len(res.json()))
    for result in res.json():
        print('Getting website for %s' % result['company'])
        try:
            res = requests.get(result['company_url'])
            homepages.append(res)
        except Exception as err:
            print('Unable to get site for %s' % result['company'])

    return homepages

a = get_sites()
A much cleaner set of code changes for instrumentation, showcasing the power of monkey patching in traces.

As a side benefit of our automatic instrumentation, we can now see errors in the Datadog backend, along with the error message:


Notice how Datadog's APM automatically highlights in red the web requests which errored out.

Because we have the rest of Datadog's powerful monitoring capabilities, we can drill right down to the status of our server at the very time of the error.

Remember, tracing is meant to be run in production, so you'll see your exact traffic and errors.

More Performance Improvement Tips
If you're looking for more information on tracing a single application for performance bottlenecks, check out this blog post by Andrew McBurney, a previous intern at Datadog.

In the blog post, Andrew dives deep into performance improvements with Datadog.


Last modified: Thursday, September 27, 2018, 10:29 PM

Previous Module

Next Module

Powered by Totara