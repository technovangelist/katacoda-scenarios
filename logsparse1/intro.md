<p>The grok parser is probably going to be what you reach for first in most cases. We chose to use the grok parser because it's a well-recognized standard to parse log entries. With grok, you can turn unstructured log and event data into structured data. Grok comes with a lot of reusable patterns to parse integers, IP addresses, hostnames, etc.
<br><br>
Special rules can be written with the **%{MATCHER:EXTRACT:FILTER}** syntax:<br>
<ol>
<li>Matcher: rule (possibly a reference to another token rule) that describes what to expect (number, word, notSpace, etc.)
<li>Extract (optional): an identifier representing the capture destination for the piece of text matched by the MATCHER.
<li>Filter (optional): a post-processor of the match to transform it
</ol>
Let’s start working with some simple examples to see how this works. To do this, you are going to submit some simple log lines to Datadog that you can manipulate.
</p>
