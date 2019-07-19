title=RIOT 2019: The role of compilers in the Renjin Project
date=2019-07-18
type=post
status=published
author=Alexander Bertram
lang=en
excerpt=At RIOT 2019, Alex recapped some recent developments in the Renjin project, and gave an overview of the growing role that compilers have played in making an JVM-based R interpreter a reality.
~~~~~~


I was really excited to co-host the fourth [RIOT workshop](https://riotworkshop.github.io/), co-located
with UseR! 2019 in Toulouse. I've personally learned a lot from the
previous RIOT workshops, and was delighted to welcome a big crowd to
the workshop.

My colleague Maarten-Jan made a rough recording of my talk:

<script src="https://fast.wistia.com/embed/medias/apkbi0495d.jsonp" async></script><script src="https://fast.wistia.com/assets/external/E-v1.js" async></script><div class="wistia_responsive_padding" style="padding:56.25% 0 0 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><div class="wistia_embed wistia_async_apkbi0495d videoFoam=true" style="height:100%;position:relative;width:100%"><div class="wistia_swatch" style="height:100%;left:0;opacity:0;overflow:hidden;position:absolute;top:0;transition:opacity 200ms;width:100%;"><img src="https://fast.wistia.com/embed/medias/apkbi0495d/swatch" style="filter:blur(5px);height:100%;object-fit:contain;width:100%;" alt="" aria-hidden="true" onload="this.parentNode.style.opacity=1;" /></div></div></div></div>

What I wanted to communicate was how the project
initially started as a "rewrite" of GNU R, and has now evolved into
a set of tools that automatically transforms millions of lines of C,
C++, Fortran and R code to meet new needs and run in new environments.

Renjin does provide a new and hopefully improved interpreter and
Just-in-Time (JIT) compiler built on the JVM, but the lion's share of
the R community's enormous investment in numerical and statistical routines
is transformed rather than replaced.

My [slides](https://docs.google.com/presentation/d/1VS3AHqTzuzIdH5NZz7w3974tmh2M9LqrhCprDMwUHhg) are also available.

We had a full day of great talks, including:

* [The R Bytecode Compiler and VM](http://homepage.divms.uiowa.edu/~luke/talks/Riot-2019.pdf) by Luke Tierney
* [R Melts Brains](https://www.dropbox.com/s/2b4w34my0kokrrm/RIOT.pdf?dl=0) from Jan Vitek

Will post more links as they become available!
