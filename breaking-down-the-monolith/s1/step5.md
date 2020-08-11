# A Watchful Eye

Our [APM Services Map](https://app.datadoghq.com/apm/map) would be even better with an indicator of their individual health. Not only will it help communicate services health to your team, but they can provide uniquely tailored troubleshooting steps for when alerts happen on any of the services.

1. Go to the APM -> Services link in Datadog
1. Click on the "discounts-service" in the list
1. At the top, you will see a blue outlined button that says "No Monitors or Synthetic Tests" to click
1. Next you will see a list of suggested monitors so let's enable the "Service discounts service has an abnormal change in throughput on env:ruby-shop"

A great place to start with services when they are separated out is to keep an eye on network latency. Especially when these services cross regional or data center boundaries. Network performance and reliability will change how you think of software design and behavior with microservices.
