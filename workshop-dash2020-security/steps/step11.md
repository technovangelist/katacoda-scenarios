Inspect one of the logs and add [facets](https://docs.datadoghq.com/logs/explorer/facets/) for the attributes which you created.
* `@network.client.ip`
* `@usr.id`
* `@evt.name`
* `@evt.outcome`
* `@evt.reason`

Now that you have added the facets, rerun the attacker script so you can search and graph on the faceted attributes.

```
docker run -d --network=securityworkshop_default attacker
```{{execute}}
