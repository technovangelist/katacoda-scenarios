Let's look at a specific query which can help us understand what is going on in this attack. Configure the Log Analytics Top List view with the following:

Query: `@evt.name:authentication @evt.outcome:failure`

Count Unique: `@usr.id`

Group By: `@network.client.ip`

Top 100

We can see with this query that there are a large number of IPs with a high number of unique users who failed to login.
This is indicative of a [credential stuffing attack](https://owasp.org/www-community/attacks/Credential_stuffing).
Let's take note of the count of unique users failing to login and we will use this number to help us derive a threshold
to detect this attack in the future.

Click the “Export to detection rule” button.
