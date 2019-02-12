title=Presenting Renjin's JIT Loop Compiler at RIOT 2016 [video]
date=2016-07-03
type=post
status=published
author=Alex Bertram
lang=en
excerpt=Watch a recording of Alex's presentation on Renjin's Just-in-Time Loop Compiler.
~~~~~~

Although I wasn't able to make it to UseR! this year, I was able to join
many participants at <a href="http://riotworkshop.github.io/">RIOT 
2016</a>, the "R Implementation, Optimization and Tooling Workshop".

Like last year, there was a great opportunity to hear war stories 
from those working up close and personal with the internals of R 
implementations.

I gave a presentation on Renjin's JIT Loop Compiler, which is intended
to compile loops and other repeatedly-executed portions of R code into
extremly efficient machine code upon execution. It's still not quite
ready for prime time, but with the latest release of Renjin, it's now
merged into master, but still behind a flag.

You can turn it on via the command line with the `--compile-loops` flag,
or with the `-Drenjin.compile.loops=true` system property if you're running 
Renjin in an embedded context.

Here's a recording of the talk I gave (<a href="/assets/downloads/Renjin-Riot-2016.pdf">PDF</a>) :

<script src="https://fast.wistia.com/embed/medias/48jrf19ssx.jsonp" async></script><script src="https://fast.wistia.com/assets/external/E-v1.js" async></script><div class="wistia_embed wistia_async_48jrf19ssx" style="height:480px;width:640px">&nbsp;</div>

Thanks to everyone for great presentations, great questions, and lots of
ideas!


