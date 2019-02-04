title=Learning from NSF DALI 13
date=2013-11-04
type=post
author=Alexander Bertram
status=published
lang=en
excerpt=The DALI workshop brought together an amazing group of scientists, language implementors, and VM-wonks in one room last week. So many great ideas!
~~~~~~

Last week I had a chance to join the [National Science Foundation Workshop on Dynamic Languages for Scalable Data Analytics](http://www.dynali.org/talks.html), or [#dali13](https://twitter.com/search?q=%23dali13) and share an [update](/assets/downloads/Renjin_Road_DALI.pdf) on Renjin's design and progress towards full compatibility with GNU R.

Besides getting a chance to see Beautiful Indianpolis for the first time, it was really an incredible group that brought together scientists with real data scalability problems, and those of us who are trying to build solutions.

I learned a lot, on topics diverse as concurrent garbage collection, automatic parallization, to VM design. 

Here are some links to projects I'm excited about:

  + Big thanks to [Tomas](http://www.cs.purdue.edu/homes/tkaliber/) and [Floreal](http://www.labri.fr/perso/fmoranda/) the Purdue team for walking me through their research into a [self-rewriting AST interpreter for R](https://github.com/allr/fastr).  Many great ideas that can be integrated into Renjin!
  
  + Duncan Temple Lang is working on [Rllvm](https://github.com/duncantl/Rllvm) a package for GNU R that allows you to translate R code to LLVM IR, play with it, and then compile to native code.
    
  + With [MacLab](http://www.sable.mcgill.ca/mclab/), the McGill University crew is working on an open-source toolkit for analyzing and compiling Matlab code. It sounds like they face many similiar challenges that an R (re)implemention does as Matlab also lacks a formal specification. 
    
  + Hadley Wickham gave an update on [dplyr](https://github.com/hadley/dplyr), which also uses deferred computation to improve performance on data frame operations, but written largely in user space. Very curious about the C++ interpreter for R expressions!
      
  + [Ryan Newton](http://www.cs.indiana.edu/~rrnewton/homepage.html) [Data.Array.Accelerate](http://hackage.haskell.org/package/accelerate) with me, which is a DSL for array computations embedded in Haskell with pluggable backends targeting CUDA, OpenCL, etc.  Conceptually very similar to Renjin's Vector Pipeliner, and much to learn from the implementation. (Thanks [Ryan]!)
    
  + [Chandra Krintz](http://www.cs.ucsb.edu/~ckrintz/) spoke about [StochSS](http://stochss.org) project that aims to provide stochiastic simulation as a service for life science researchers, using the [AppScale platform](http://www.appscale.com/), an open source clone of AppEngine.  Renjin makes it MUCH easier to leverage the AppEngine/AppScale platform, so I'm excited about potential for collaboration here.
    
Thanks to Jan Vitek for organizing another great opportunity for collaboration!

