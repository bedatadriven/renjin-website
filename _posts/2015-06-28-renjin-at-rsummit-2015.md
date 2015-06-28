---
layout: post
author: 
    name: Maarten-Jan Kallen
    url: https://plus.google.com/u/0/111907942618741434760
lang: en
tags: r-bloggers
title: "Renjin presented at the R Summit & Workshop in Copenhagen"
excerpt: BeDataDriven was invited to attend the special workshop on the
    R programming language taking place right before the 2015 UseR! conference
    in Denmark. We took the opportunity to present our research project "R as 
    a Query Language".
---
  
As a follow-up to last year's
[Directions in Statistical Computing meeting](http://www-huber.embl.de/dsc/index.html)
in Brixen, this year sees the
[R Summit & Workshop](http://info.cbs.dk/rsummit2015/home)
coming to Copenhagen. And
[like last year](http://blog.revolutionanalytics.com/2014/07/dsc-2014.html)
the groups behind the alternative R interpreters are presenting the current
status of their efforts. This includes Renjin, the interpreter that runs in the
Java Virtual Machine. So this was a great opportunity to present the first results of
[Hannes Mühleisen's](https://twitter.com/hfmuehleisen)
[research project in collaboration with BeDataDriven](www.bedatadriven.com/news/2014/collaboration-with-cwi.html).

Below are the slides from the presentation and we will highlight some of these
in the remainder of this article.

<div class="ratio4-3"><div>
<object data="/assets/downloads/Renjin-Rsummit2015.pdf" type="application/pdf" width="100%" height="100%">
 
  <p>It appears you don't have a PDF plugin for this browser.
  No biggie... you can <a href="myfile.pdf">click here to
  download the PDF file.</a></p>
  
</object></div></div>

The key idea of the *R as a Query Language* is to use Renjin's ability to defer
computations (or evaluations): the interpreter will not do any work until
a result is needed, for example when the result of a computation must be
printed to the console with the `print()` function. Once the interpreter gets
to such a point it has a picture, a *graph*, of the computation up to that
point. With this graph, the interpreter can decide how to execute these
computations in an optimal way much like a database optimizes the execution of
a query written in SQL (hence the name of the project). Slide 12 (shown below)
has an example of how a snippet of R code is translated into a call graph.

![Example of the execution graph at runtime from slide 12](/assets/img/r-summit-raaql-frames-0011.png)

Once the interpreter needs to produce a result it will look at the execution
graph and apply one or more optimizations. Slide 10 (shown below) lists a few
of the optimizations that we have implemented so far.

![Types of optimizations we can apply to the execution graph from slide 10](/assets/img/r-summit-raaql-frames-0009.png)

Let's discuss a few of these in more detail and start with *selection pushdown*
as shown in slide 13. It contains the following (contrived) example which
includes an expensive calculation (i.e. the factorial) on a (potentially very
large) vector `a`, followed by a selection of a small subset of the result.
This may seem like something you obviously never do, but is not uncommon in
longer and more complex programs.

```{.r}
b <- factorial(a) # 'a' is a large vector
# ...
b[1:10]
```

![Example of selection pushdown on slide 13](/assets/img/r-summit-raaql-frames-0012.png)

In essence this optimizer ensures that we don't do unnecessary calculations if
we only require a (small) subset of these in the end. The pushdown of the
selection operator `[` by the interpreter means that it has automatically
converted the code above to the equivalent of `factorial(a[1:10])`.

Then we show an example of *common expression elimination* which means that we
*recycle* parts of the calculation that we have already performed earlier in
a loop. In the following example code, the vector `a` doesn't change while in
the loop so it is not necessary to calculate `min(a)` and `max(a)` in every
iteration of the `for` loop.

```{.r}
for (i in 1:100) {
  print((a[i] - min(a))/(max(a) - min(a)))
}
```

As is shown in the slide, these parts of the iteration get cached and reused. 

![Example of recycling of expression results on slide 15](/assets/img/r-summit-raaql-frames-0014.png)

Unlike GNU R, Renjin treats vectors as
[immutable objects](https://en.wikipedia.org/wiki/Immutable_object) which
enables not only the recycling of sub-expressions but also implicit (i.e.
automatic) parallelization. This means that the interpreter will assign
different code paths to multiple threads if these are available. No special
packages or human intervention required!

Finally, the last slide (shown below) compares the computation times of GNU
R versus Renjin (with and without optimizations) for an experiment with the
[survey package](http://cran.r-project.org/web/packages/survey/). Unlike the
micro-benchmarks discussed earlier, this is a realistic use-case that is also
very typical of the type of calculations that R is used for. The data comes from the
[American Community Survey](http://www.census.gov/programs-surveys/acs/) and
the experiment involves the calculation of the average age using replication
weights.

![Comparison of computation time for an experiment with the survey package](/assets/img/r-summit-raaql-frames-0019.png)

Renjin is slower than GNU R (version 3.1.3 in this case) if no optimizations
are applied (*Renjin -opt*). We attribute this to the use of virtual function
calls in the JVM versus the tight C loops on arrays used in GNU R. In other
words: Renjin's flexible architecture comes at a cost. But the whole point of
this flexible architecture is to improve performance in a strategic way, i.e.
not by local optimizations or *band-aids*. Once we enable all the optimizers in
Renjin, it dramatically outperforms GNU R even if given only a single thread
(*Renjin 1t*). Using multiple threads (*Renjin*) the computation time goes down
even more, but this experiment didn't lend itself very well to parallelization.
So the benefits of these optimizations demonstrated with the micro-benchmarks
translate to greater performance in realistic use cases.

So what's next? We have only touched the surface of the type of optimizations
that can be considered for the execution graph of an R program. We would like
to expand these to include cost-based optimization techniques, where
alternative execution graphs are enumerated and ranked using a cost model. Such
cost-based optimizers can be used to decide if parts of the work can and should
be shipped to a specialized *worker* such as a database or a GPU.

