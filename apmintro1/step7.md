# Automatic Instrumentation

Because the `requests` library is one of the automatic libraries provided by Datadog, we can instrument using that.

1.  Replace the code in `first.py` as follows:


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

![trace error](/technovangelist/scenarios/apmintro1/assets/trace-error.png)

Notice how Datadog's APM automatically highlights in red the web requests which errored out.

Because we have the rest of Datadog's powerful monitoring capabilities, we can drill right down to the status of our server at the very time of the error.

Remember, tracing is meant to be run in production, so you'll see your exact traffic and errors.

# More Performance Improvement Tips

If you're looking for more information on tracing a single application for performance bottlenecks, check out this <a href="https://www.datadoghq.com/blog/engineering/using-datadog-apm-to-find-bottlenecks-and-performance-benchmarking/" target="_datadog">blog post</a> by Andrew McBurney, a previous intern at Datadog.

In the blog post, Andrew dives deep into performance improvements with Datadog.
