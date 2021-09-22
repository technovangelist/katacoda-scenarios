1. Create a new Timeboard for monitoring CoreDNS.
1. The first thing we should look at is how busy CoreDNS is. Looking at `coredns.request_count` will provide that. Create a timeseries looking at that metric.
1. Request count shows us the raw requests, but we can also look a bit more deeply to learn more. Try adding `coredns.cache_hits_count` and dividing that by the request count to see the cache hit rate. A low hit rate may show that you should raise the TTL value.
1. Reviewing DNS latency is also useful. Try dividing `coredns.request_duration.seconds.sum` by `coredns.request_duration.seconds.count` to see an average duration. 
1. When CoreDNS encounters an error, an RCODE is generated. Displaying `coredns.response_code_count` and splitting it out by rcode is a great way to see if certain errors are more prevalent than others. 
1. And of course, don't forget the core system resources. CPU, open file descriptors, and memory should all be added to your dashboard. 