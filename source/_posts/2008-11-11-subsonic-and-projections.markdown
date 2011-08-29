--- 
layout: post
title: SubSonic and Projections
date: "2008-11-11"
comments: true
link: false
---
<p>I've said in the past that we use SubSonic on my current project.&#160; It does what it says it does (mostly) and generates some usable code off of an existing database.&#160; I do have my qualms about it, mostly because of my bias to look at things from the object/domain world rather than the database world.&#160; But I am a committer, so my energy complaining would be better off contributing goodness to the project.</p>  <p>With the most recent release of the new query API in SubSonic, we were given a lot of flexibility.&#160; This was much needed in our project because getting single results and collections off of a single entity is rarely sufficient for complex applications.&#160; Often times the data needed to display on a page comes from multiple tables.</p>  <p>In the past, I was forced to do this sort of ugly nastiness:</p>  {% codeblock %}<span class="rem">//get schedules (1 query)</span>
Schedule[] schedules = _repository.GetSchedulesInRange(start, end);
<span class="rem">//get employee info (2 queries)</span>
Employee[] employees = _repository.GetEmployeesInSchedules(schedules);
ScheduleDisplayMapper mapper = <span class="kwrd">new</span> ScheduleDisplayMapper();
<span class="kwrd">return</span> mapper.Map(schedules, employees);{% endcodeblock %}
<p>This function returned an array of `ScheduleDTO` objects that were used to bind to a view.&#160; The lack of joins at the database level was really killing our productivity and in some cases, performance.&#160; It often took more code to write the query than you'd expect, because you would have to perform it in steps.</p>
<blockquote>
<p>Note: I'm really pragmatic about performance, so 2 queries when 1 is possible doesn't usually matter in the long run.&#160; Of course if this *is* a perf bottleneck, then of course, optimize.&#160; I much prefer to balance programmer performance over unnoticeable application performance.</p>
</blockquote>
<p>With the new query API, I can now do this:</p>
{% codeblock %}SqlQuery query = <span class="kwrd">new</span> Select()
.From&lt;OnCallSchedule&gt;()
.InnerJoin(Area.AreaIdColumn, OnCallSchedule.AreaIdColumn)
.InnerJoin(EmployeeProfile.EmployeeProfileIdColumn, OnCallSchedule.EmployeeProfileIdColumn)
.Where(OnCallSchedule.StartDtColumn).IsLessThanOrEqualTo(date)
.And(OnCallSchedule.EndDtColumn).IsGreaterThanOrEqualTo(date)
.OpenExpression()
.And(Area.AreaIdColumn).IsNull()
.Or(Area.AreaIdColumn).IsEqualTo(areaId)
.CloseExpression()
.OrderAsc(OnCallSchedule.PriorityColumn.ColumnName);{% endcodeblock %}
<p>I get complete refactoring support, intellisense, and type-safety.&#160; But now we have a different problem:&#160; we're not returning a single entity anymore.&#160; We're returning a combination of columns from different tables.</p>
<p>To build my DTO objects, I then had to resort to functions like this:</p>
{% codeblock %}<span class="kwrd">public</span> <span class="kwrd">static</span> ScheduleDTO FetchFromRow(IDataReader dr)
{
<span class="kwrd">int</span> i = 0;
ScheduleDTO schedule = <span class="kwrd">new</span> ScheduleDTO();
schedule.OnCallScheduleId = dr.GetGuid(i++);
schedule.Start = dr.GetDateTime(i++);
schedule.End = dr.GetDateTime(i++);
schedule.Comments = dr[i++] <span class="kwrd">as</span> <span class="kwrd">string</span>;
schedule.Priority = dr.GetInt32(i++);
schedule.EmployeeProfileId = dr.GetGuid(i++);
<span class="kwrd">string</span> firstName = dr.GetString(i++);
<span class="kwrd">string</span> lastName = dr.GetString(i++);
schedule.EmployeeName = firstName + <span class="str">&quot; &quot;</span> + lastName;
<span class="kwrd">return</span> schedule;
}{% endcodeblock %}
<p><strong>Excuse me while I go vomit</strong>.&#160; This code gives me nightmares from the days when I wrote my own data access layer by hand.&#160; We as programmers should never be writing code that is simply of the form <em>copy this value to that value.&#160; Cast X to Y</em>.&#160; It's specifically the reason why data binding exists for forms.</p>
<p>After writing two of these methods I decided we need to come up with a better way.&#160; I wanted to declaratively say, this <em>DTO maps to these columns</em>.&#160; We don't have .NET 3.5, so magic-y lambda syntax is out.</p>
<p>I decided to lean on attributes.&#160; Yes, this does add some &quot;database-y&quot; things on my DTOs, but I figured the baggage was worth it.&#160; I created a custom attribute to map properties on my DTOs to columns on a result set.</p>
<p></p>
{% codeblock %}[AttributeUsage(AttributeTargets.Property)]
<span class="kwrd">public</span> <span class="kwrd">class</span> MapToColumnAttribute : Attribute
{
<span class="kwrd">private</span> <span class="kwrd">readonly</span> <span class="kwrd">string</span> _columnName;
<span class="kwrd">public</span> MapToColumnAttribute(<span class="kwrd">string</span> columnName)
{
_columnName = columnName;
}
<span class="kwrd">public</span> <span class="kwrd">string</span> ColumnName
{
get { <span class="kwrd">return</span> _columnName; }
}
}{% endcodeblock %}
<p></p>
<p>Now to decorate my DTO....</p>
<p></p>
{% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> ScheduleDTO
{
[MapToColumn(OnCallSchedule.Columns.Priority)]
<span class="kwrd">public</span> <span class="kwrd">int</span> Priority
{
get { <span class="kwrd">return</span> _priority; }
set { _priority = <span class="kwrd">value</span>; }
}
[MapToColumn(EmployeeProfile.Columns.EmployeeProfileId)]
<span class="kwrd">public</span> Guid ProfileId
{
get { <span class="kwrd">return</span> _profileId; }
set { _profileId = <span class="kwrd">value</span>; }
}
<span class="rem">/* snip */</span>{% endcodeblock %}
<p></p>
<p>SubSonic has a struct called <em>Columns</em> that contains all of the column names. I had to edit the default template to make these constants rather than statics, so that they would be usable in the attribute constructors.</p>
<p>Now that all of the mapping information has been provided declaratively, I can now leverage a generic mapper class to do the copying form DataReader over to DTO.</p>
<p></p>
{% codeblock %}<span class="kwrd">public</span> T Map&lt;T&gt;(IDataReader dr) <span class="kwrd">where</span> T : <span class="kwrd">new</span>()
{
Type type = <span class="kwrd">typeof</span>(T);
T target = <span class="kwrd">new</span> T();
<span class="kwrd">foreach</span>(PropertyInfo property <span class="kwrd">in</span> type.GetProperties())
{
<span class="kwrd">foreach</span>(MapToColumnAttribute attr <span class="kwrd">in</span> ReflectionUtil.GetAttributes&lt;MapToColumnAttribute&gt;(property))
{
<span class="kwrd">object</span> <span class="kwrd">value</span> = dr[attr.ColumnName];
property.SetValue(target, <span class="kwrd">value</span>, <span class="kwrd">null</span>);
}
}
<span class="kwrd">return</span> target;
}{% endcodeblock %}
<p></p>
<p>This function takes a DataReader that currently on a record, loops over the properties of the DTO looking for our attribute.&#160; It then sets the value using reflection.&#160; The beauty of this is, I don't have to worry about casting anything.&#160; As long as the types of the columns match up with the type of the property, then we're golden.</p>
<p>The act of mapping projections of entities onto flat data transfer objects is now incredibly simple:</p>
<p></p>
{% codeblock %}ProjectionMapper mapper = <span class="kwrd">new</span> ProjectionMapper();
<span class="kwrd">using</span>(IDataReader dr = query.ExecuteReader())
{
<span class="kwrd">while</span>(dr.Read())
results.Add(mapper.Map&lt;ScheduleDTO&gt;(dr));
}{% endcodeblock %}
<p></p>
<p></p>
<p>You can take this one step further to encapsulate the looping over the data reader as well.</p>
<p>It was a nice feeling to be able to remove 17 lines of query code and 1 40 line mapping class and replace it with a tighter query and a few attributes.</p>
<p>Deleting code is fun.</p>
<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:226b7435-322b-43b9-b942-f3fbbede0838" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/SubSonic" rel="tag">SubSonic</a></div>
