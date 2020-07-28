1.  Wait until you see the **Provisioning Complete** message on the terminal before opening the app. 
1.  Launch the Storedog app like you did before. If you still have it open from the previous lab, you will need to close that and start a new one. It may use a new IP address and we want to make sure you are seeing the right traces.
2.  Navigate around the app just as you did before. The goal here is to generate some new traffic to the site.
3.  The first thing to do when setting up APM is to add the APM language library. For Ruby that means adding `ddtrace` to the Gemfile. You can see this at `store-frontend-broken-instrumented/Gemfile`. This actually is loading `store-frontend-broken-instrumented/common_spree_dependencies.rb` so take a look there. Notice ddtrace right at the top. There are a few other libraries here that help with traces, including `logging-rails` and `lograge`.
4.  Next take a look at `store-frontend-broken-instrumented/config/initializers/datadog.rb`. Update the file as shown here:
      ```ruby
      Datadog.configure do |c|
        # This will activate auto-instrumentation for Rails
        c.use :rails, {'analytics_enabled': true, 'service_name': 'store-frontend'}
        # Make sure requests are also instrumented
        c.use :http, {'analytics_enabled': true, 'service_name': 'store-frontend'}
        c.tracer hostname: 'agent'
      end
      ```
5.  This sets `analytics_enabled` to true for both Rails auto instrumentation and Http instrumentation. 
6.  Run `./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}