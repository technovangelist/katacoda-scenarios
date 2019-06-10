# Automatic Distributed Tracing

Now that we've seen how to manually add distributed tracing headers to our internal infrastructure, let's set things up the easy way.

If you are still running **step01**, stop it by pressing **CTRL-C** in the first terminal tab. Then run:

`docker-compose stop;docker-compose rm -f`{{execute T1}}

Now start the next environment with:

`./start02`{{execute T1}}

The code for this section can be found in the **step02** directory.

We can add automatic distributed tracing to Datadog supported libraries by adding a simple `distributed_tracing=True` to our **TraceMiddleware**.

This adds checks for the headers from before and automatically continues as a child span where necessary.

If we use Datadog's Python library function **patch**, we can also automatically instrument the **requests** library, along with the **redis** server we have running.

To send our headers along with the automatically instrumented **requests** library, we must also `import config from ddtrace`, and add the following lines:

```python
from ddtrace import tracer, patch, config

# Tracer configuration
tracer.configure(hostname='agent')
patch(requests=True)

# enable distributed tracing for requests
# to send headers (globally)
config.requests['distributed_tracing'] = True
```

By using the Datadog patch, we get more default metadata of our request along with the information set.

Now we can see our traces as they propagate across our entire distributed system.

![automatic distributed](/technovangelist/scenarios/apmintro2/assets/automatic-distributed.png)

If you want to jump directly into the code here and explore with Datadog, you can press CTRL-C, and then:

`docker-compose stop;docker-compose rm -f;./start03`{{execute T1}}

But we're still running a simplified system. Let's add a datastore and see how that changes what distributed tracing shows us.


