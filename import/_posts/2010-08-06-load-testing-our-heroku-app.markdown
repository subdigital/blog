--- 
layout: post
title: Load Testing our Heroku app
date: 2010-8-6
comments: true
link: false
---
I've said many times before how much I love Heroku. Though they've had an unusually large amount of downtime this week (~1 hour), I'm still loving their service. One of the applications that we're building is expecting a large wave of traffic shortly following a blitz PR campaign. The golden question of the hour is: How much traffic can we handle?

Currently we're on the Koi 1 plan, which gives us a 20GB database (shared) and 1 dyno. A "dyno" is basically 1 concurrent request. It's very similar to a super market. You get in line and you are served in the order in which you came. If some jackass has a cartload of Natural Light &amp; Cheeze Whiz in front of you, you're gonna have to wait a while. Adding another Dyno is like opening a 2nd lane.

The key to good performance on Heroku is to watch the Queue Depth. If you ever reach too many people in the queue at one time your app will stop serving up requests past that mark, you'll get a Backlog Too Deep error. I'm not sure what the limit is, but I'm guessing it's around 100 (which is HUGE).

For more information on Heroku performance, see their <a href="http://docs.heroku.com/performance" target="_blank">excellent docs</a>.

To perform my tests I'm using 2 tools: <a href="http://httpd.apache.org/docs/2.0/programs/ab.html" target="_blank">Apache Bench</a> &amp; <a href="http://www.newrelic.com/" target="_blank">New Relic RPM</a>. Both are stellar.
<h2>Test 1: Serving up the landing page (1 Dyno, 5000 requests, 20 at a time)</h2>
This is a simple GET request that the Heroku routing mesh likely caches heavily. There's no database queries on the homepage and no logic.

# Requests: 5000Concurrency: 20# of Requests/Sec: 85

This is pretty darn good. 50% of the requests are served in under 300ms and the max request took less than 1 second. No requests failed.
<h2>Test 2: A simple API read operation (1 Dyno, 5000 requests, 20 at a time)</h2>
{% codeblock %}Concurrency Level: 20
Time taken for tests:   68.067 seconds
Complete requests:      5000
Failed requests:        0
Write errors:           0
Total transferred:      4276315 bytes
HTML transferred:       2665000 bytes
<strong>Requests per second:    73.46 [#/sec] (mean)</strong>
Time per request:       272.267 [ms] (mean)
Time per request:       13.613 [ms] (mean, across all concurrent requests)
Transfer rate:          61.35 [Kbytes/sec] received
Connection Times (ms)min  mean[+/-sd] median
maxConnect:       68   75   4.2     74      97
Processing:    85  197  73.9    180     607
Waiting:       85  197  73.9    180     607
Total:        157  272  73.8    255     685
Percentage of the requests served within a certain time (ms)
50%    255
66%    291
75%    313
80%    325
90%    365
95%    407
98%    477
99%    535
100%    685 (longest request){% endcodeblock %}
Again, great results. This is due to caching of course, but at least we know we can handle lots of requests on this API.
<h2>Test 3: A simple API write operation (1 Dyno, 5000 requests, 20 at a time)</h2>
This API operation inserts 2 records in the database. Again, 5000 requests, 20 at a time.
{% codeblock %}Concurrency Level:      20
Time taken for tests:   320.981 seconds
Complete requests:      5000
<strong>Failed requests:        4165
</strong>   (Connect: 0, Receive: 0, Length: 4165, Exceptions: 0)
Write errors:           0
Total transferred:      4022365 bytes
Total POSTed:           1935387
HTML transferred:       2651618 bytes
Requests per second:    15.58 [#/sec] (mean)
Time per request:       1283.923 [ms] (mean)
Time per request:       64.196 [ms] (mean, across all concurrent requests)
Transfer rate:          12.24 [Kbytes/sec] received 5.89 kb/s sent  18.13 kb/s totalConnection 

Times     (ms)min  mean[+/-sd] median
maxConnect:   68   71   3.9     70     104
Processing:   134 1210 865.8    975    5559
Waiting:      134 1210 865.8    975    5558
Total:        202 1281 865.7   1048    5627

Percentage of the requests served within a certain time (ms)
50%   1048
66%   1364
75%   1638
80%   1819
90%   2430
95%   3176
98%   3898
99%   4248
100%   5627 (longest request){% endcodeblock %}
You can see here that we failed 4165 requests. That's not good! Let's try adding a dyno and do it again.
<h2>Test 4: A simple API write operation (2 Dynos, 5000 requests, 20 at a time)</h2>
{% codeblock %}Concurrency Level: 20
Time taken for tests:   135.882 seconds
Complete requests:      5000
Failed requests:        0
Write errors:           0
Total transferred:      4045448 bytes
Total POSTed:           1935774
HTML transferred:       2675000 bytes
Requests per second:    36.80 [#/sec] (mean)
Time per request:       543.530 [ms] (mean)
Time per request:       27.176 [ms] (mean, across all concurrent requests)
Transfer rate:          29.07 [Kbytes/sec] received
13.91 kb/s sent
42.99 kb/s totalConnection Times (ms)min  mean[+/-sd] median
maxConnect:       67   95  32.7     72     979
Processing:   121  448 162.4    420    1481
Waiting:      121  448 162.5    419    1481
Total:        199  543 154.4    515    1549
Percentage of the requests served within a certain time (ms)
50%    515
66%    580
75%    624
80%    654
90%    751
95%    840
98%    946
99%   1034
100%   1549 (longest request){% endcodeblock %}
We're getting a pretty healthy 36 requests per second now, and look, no errors!
<h2>Test 5: A simple API write operation (2 Dynos, 10000 requests, 20 at a time)</h2>
{% codeblock %}Concurrency Level: 20
Time taken for tests:   326.317 seconds
Complete requests:      10000
Failed requests:        0
Write errors:           0
Total transferred:      8091062 bytes
Total POSTed:           3870000
HTML transferred:       5350000 bytes
Requests per second:    30.65 [#/sec] (mean)
Time per request:       652.634 [ms] (mean)
Time per request:       32.632 [ms] (mean, across all concurrent requests)
Transfer rate:          24.21 [Kbytes/sec] received
11.58 kb/s sent
35.80 kb/s totalConnection Times (ms)min  mean[+/-sd] median
maxConnect:       68   72  13.8     70    1004
Processing:   113  580 233.1    539    2145
Waiting:      113  580 233.1    539    2145
Total:        183  652 233.5    610    2213
Percentage of the requests served within a certain time (ms)
50%    610
66%    701
75%    771
80%    822
90%    971
95%   1103
98%   1254
99%   1374
100%   2213 (longest request){% endcodeblock %}
We slipped a tad on overall throughput (down to 30 reqs/sec) but we still served up all of the requests in a reasonable time without any failures.
Let's check out New Relic &amp; See what it says.
<img src="/images/newrelic-heroku-testing2.png"  height="282"  /> In this graph you can see the overall HTTP Throughput (higher is better) against the Heroku backlog depth. The more dynos you have, the quicker your backlog is cleared out, equating to more throughput. You can clearly see that we are now hitting a limit on the throughput we can handle because the queue depth is increasing. We might choose to optimize the site or add another dyno to squeeze some more perf out of this.
Also in the image if you were to mouseover on the queue stacks on the website, you'd see that my peak queue depth was 29. That's pretty high, and you can definitely see a cap in the total # of requests that we can serve.
In the end, I'm able to pretty reliably say that we can handle a 10k request spike when running on 2 dynos. I'd suggest more dynos if the client wanted to handle more than that.
Gotta love tools that make investigation like this easy. Props to Heroku &amp; New Relic.
