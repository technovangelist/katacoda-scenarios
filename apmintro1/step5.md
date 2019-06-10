# Tracing an HTTP Request

Tracing is most useful when we get to see what's going on in our systems. Let's do two HTTP requests that rely on each other, and see how tracing allows us to visualize the process.

We'll use the `requests` library which is already installed to the image to do some HTTP GETs on the Github jobs API.

1.  Replace the code in first.py as follows. It will run a request to get a list of the first 50 Python jobs on GitHub, and then try grabbing each job listing's company site

    ```python
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
    ```

*Depending on the width of your browser, lines may be wrapped in an odd way. You can change the width of the tutorial pane to see the source code correctly.*

Notice the new spans that are getting created.

One span encapsulates the job of getting the initial API request, and a new span is created for each request attempting to grab the homepage of a job's company.

