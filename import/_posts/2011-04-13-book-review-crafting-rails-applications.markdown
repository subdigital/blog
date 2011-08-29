--- 
layout: post
title: "Book Review:  Crafting Rails Applications"
date: 2011-4-13
comments: true
link: false
---
<img src="/images/capa_crafting.png"  style="float:left; margin-right:10px; margin-bottom:10px;"  />

<p>I just finished with <a href="http://www.amazon.com/gp/product/1934356735/ref=as_li_ss_tl?ie=UTF8&amp;tag=flux88com-20&amp;linkCode=as2&amp;camp=1789&amp;creative=390957&amp;creativeASIN=1934356735">Crafting Rails Applications</a><img src="http://www.assoc-amazon.com/e/ir?t=&amp;l=as2&amp;o=1&amp;a=1934356735" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" /> by <a href="http://blog.plataformatec.com.br/author/josevalim/">José Valim</a>. The book claims to teach Expert Practices for Everyday Rails Development. I didn't find it to be exactly that, however I did enjoy it and I learned a ton.</p>
<h2>The Good</h2>The book flows pretty well. Each chapter contains a challenge or set of related challenges and it's pretty easy to follow along with the code. Each example contains automated tests, and he creates a gem for almost each solution, so that it is easy to see how to modularize things.<br />
The coverage of Rails internals is really enlightening. Sometimes it can be a bit dry, but you'll learn quite a few things about Renderers, Responders, Engines, Railties, Routing, Rack, Instruments, and more.<br />
The book also contains a wide range of technology topics. José doesn't just utilize Rails &amp; ActiveRecord. Other examples include MongoMapper, Redis, and Sinatra.<br />
<h2>The Bad</h2>Even though each of the examples contains unit tests, they are written in a style that I find to be problematic in real systems. The concise nature of the tests is probably an artifact of being printed, but most of the testing examples utilize few test classes with many assertions per test method.<br />
In addition, though he "writes" the tests before implementation, this actually hurts understandability in some cases. The reason is most of the tests read as if he already knew the implementation and knew exactly how to test it. But it isn't apparent to the reader.<br />
I tend to prefer RSpec with 1 assertion per test method and many fine-grained methods that test various behaviors in each context my system is in. The book's Test::Unit style wasn't something I'd suggest as a good way to test real applications.<br />
<h2>The Bottom Line</h2>Ultimately I think the book is excellent, and certainly gives plenty of information about Rails 3 internals. I think newcomers would probably be lost, but if you're past the newbie stage with Rails then this book is recommended.<br />
<br />
