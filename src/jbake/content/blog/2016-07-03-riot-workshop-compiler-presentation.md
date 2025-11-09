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

<div class="video"><iframe src="https://iframe.mediadelivery.net/embed/463862/144687b2-1ca4-4a67-83f4-474c5b564905?autoplay=false&loop=false&muted=false&preload=false&responsive=true" loading="lazy"  allow="accelerometer;gyroscope;autoplay;encrypted-media;picture-in-picture;" allowfullscreen="true"></iframe></div>

Thanks to everyone for great presentations, great questions, and lots of
ideas!


