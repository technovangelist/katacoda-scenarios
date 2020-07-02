CoreDNS provides name resolution and service discovery in Kubernetes. When its performing poorly, everything is affected. When a pod needs to communicate with another pod, CoreDNS is used to figure out it's IP address. When the Datadog Agent needs to autodiscover the services to monitor, it uses CoreDNS to find them. In this lab we will create a dashboard that looks at the key metrics for CoreDNS to help you ensure everything it touches continues to be able to use the network. 