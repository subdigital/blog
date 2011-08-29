--- 
layout: post
title: My Favorite Production Software Bug
date: 2009-8-21
comments: true
link: false
---
<p>When I first graduated from college I worked for a small company doing custom development work in .NET 1.1.</p>
<p>Our largest client (coincidentally where our offices were) had a print shop and a web site for financial agents to set up and send mailings to folks inviting them to a dinner and telling them about the latest &amp; greatest annuities that they should invest all their money in.</p>
<p>The system was pretty interesting.&nbsp; With a batch job they'd print out letters, a bio card that showed the agent's photo on it, and other inserts, such as tickets to the dinner.&nbsp; These would be collated, folded, and stuffed into an envelope that would be licked, sealed, and affixed with a real stamp. (<em>People are 20 times more likely to open a letter if it has a real stamp -- and yes I just made that number up</em>).&nbsp; It was very impressive to watch it all work.</p>
<p>The website we built allowed the agents to place these orders (with optional inserts) and mail them to a set of folks matching a given demographic all online.</p>
<p><img style="margin: 10px 10px 10px 0px" align="left" alt="" src="http://www.creative-ps.com/images/content/mailsorter.jpg" /></p>
<p>Often times the agents would purchase an upgrade to have a reminder card sent to each person a week before the event occurred.&nbsp; These cards were special and even though we had a room full of expensive printers, we didn't have the ability to print these cards.&nbsp; So we'd have to outsource it to another print shop across town.</p>
<p>The process went something like this:</p>
<ul>
<li>We'd compile all the info, along with a TIF of the agent's photo and FTP it over to the other company</li>
<li>They'd print them all and drive them to the post office for mailing</li>
<li>They would charge us money</li>
</ul>
<p>All of this just worked, and I never had to see the internals of this system.&nbsp; That is, until my boss went on vacation to Mexico (at the time it was just me and him).</p>
<p>You see, an agent had sent a card to himself and a couple of his friends.&nbsp; He never received them.&nbsp; Since he had paid of for the upgrade he was understandably upset.&nbsp; They asked me to look into it.</p>
<p>I was slightly familiar with the tables, and so I went looking.&nbsp; There was a table along the lines of ResponseCardQueue.&nbsp; It contained columns such as agent_id, recipient, address, city, state, zip, and date_sent.</p>
<p>There were tens of thousands of these records.&nbsp; I issued this query:</p>
{% codeblock %}
SELECT * FROM ResponseCardQueue WHERE date_sent IS NULL{% endcodeblock %}
<p>To find that there were about 2100 records returned.&nbsp; For some reason these weren't being processed.</p>
<p>I finally found the code that was reading this, and it had some code that looked like this:</p>
{% codeblock %}
public void ProcessCards(Card[] cards)<br />{<br />&nbsp; try <br />&nbsp; {<br />&nbsp;&nbsp;&nbsp; foreach(Card c in cards)<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; string tifFilename = @&quot;\\SOME\NETWORK\PATH\&quot; + c.AgentId + &quot;.TIF&quot;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //copy details + tif image to some folder<br />&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; //zip up folder<br /><br /><br /><br /><br />&nbsp;&nbsp;&nbsp; //FTP the file to the other print shop<br />    //mark date_sent to DateTime.now<br />&nbsp; }<br />&nbsp; catch<br />&nbsp; {<br />&nbsp; }<br />}
{% endcodeblock %}
<p>There are two things to notice.&nbsp; One was that we were calculating the filename based on the column in the database.&nbsp; The 2nd was the empty catch block, effectively allowing errors to go on unnoticed.</p>
<p>In this system an agent id was an identity column in another table, so the numbers were incrementing by 1 with each new account.&nbsp; After much searching, I realized that the column type for the agent id in this table was defined as a char(4).&nbsp; So as soon as we had our 10000th record in the system, it started looking for filenames that didn't exist on the network share.</p>
<p>It would be something like this:</p>
<p>agent id 10200 would get truncated to 1020, which in our system didn't exist (most of the numbers started in the 4000's.&nbsp; So the filename didn't exist (and probably better that it errored out here rather than choose the wrong picture for the card!).&nbsp; This code threw an exception and stopped processing future records.</p>
<p>And so the unsent records piled up.&nbsp; For 4 months.</p>
<p><img style="margin: 10px 0px 10px 10px" align="right" width="137" height="174" alt="" src="http://1sdiresource.com/pile.jpg" /></p>
<p>So I diligently made the column type int and updated the records that were below that threshold to correct their agent id numbers.&nbsp; So guess what happened?&nbsp; I fixed the clog and with one big TWOOOSH all of the records were processed.</p>
<p>I felt mighty proud.</p>
<p>&nbsp;</p>
<p>Until.........</p>
<p>&nbsp;</p>
<p>A few hours later I realized that the cards would actually now be mailed!&nbsp; How embarrassing it would be to remind someone of an event that took place 3 months ago?</p>
<p>By the time I was able to explain all of this and someone jumped in their car and went to the post office just in time to grab the entire batch before it was about to be mailed.</p>
<p>We still were charged for the printing &amp; postage of those cards, however we saved ourselves the embarrassment of explaining to all of our customers that we screwed up big time.</p>
<p>I learned a valuable lesson that a simple oversight can cost a company a <em>ton</em> of money (and in this case... reputation).</p>
<p>So what's your favorite production software bug?</p>
