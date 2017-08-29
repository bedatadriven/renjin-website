---
layout: post
author: 
    name: Alexander Bertram
lang: en
title: "Highlights from UseR! 2017"
excerpt: What we learned about R and compilers from the 2017 R user conference.
---

The whole Renjin team had a chance to descend on Brussels for the 2017 UseR! Conference and the co-located
2017 [R Implementation, Optimization and Tooling (RIOT) Workshop](https://riotworkshop.github.io/). 

We had the chance to give a [few presentations on Renjin](/blog/2017-07-20-renjin-useR-2017.html), but 
we also had the opportunity to learn a lot from the other conference speakers. 
From the persepective of a language implementor, I wanted to highlight some of these talks:

## Static Analysis

There are a few independent efforts to apply static analysis techniques to R code for the purposes of optimization. 

Renjin's JIT compiler of course combines runtime information with static analysis to compile for-loops to highly efficient machine code.

But Jianqiao Zhu also spoke about the [ROSA Project](https://arxiv.org/abs/1704.02996), which uses some of the same static analysis techniques. Rather than applying them at runtime like Renjin does, ROSA is an Ahead-of-Time (AOT) compiler, which requires some user input as a substitute for the type information that Renjin gathers automatically at runtime.

And Nick Ulle also spoke about [RLLVM](https://github.com/duncantl/Rllvm)
([video](https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/An-LLVM-based-Compiler-Toolkit-for-R)), a LLVM-based Compiler Toolkit for R that seeks to provide a toolbox for applying these sort static analysis
compilations and transformations.

# R Byte Code Compiler

Tomas Kalibera gave a great presentation on GNU R's own Byte Code Compiler ([video](https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/Taking-Advantage-of-the-Byte-Code-Compiler)). 

Compared with Renjin's JIT complier, the first big difference is the unit of compilation. The GNU R Byte Code Compiler (BCC) compiles entire functions, while Renjin's JIT compiler will selectively compile loops based on the
number of expected iterations.

The second difference is when compilation takes place. Renjin compiles a loop mid-execution, using all available type information to 
generate highly-specialized machine code. The compiled loop body is thrown away after the loop finishes.

The GNU R BCC, on the other hand, compiles a function only once, and makes no assumptions about the incoming types of the arguments. 

The trade off here is that Renjin can potentially spend more time on compilation, but can in many cases apply more optimizations because
we know more about the types. We need better (and more) benchmarking to better compare the performance of these strategies.

# New Hardware

One of the big questions we want to explore with Renjin is how we can take existing R and C code that was written for 
one context and transform it in such a way that it can run faster or in a new context. So far, we've focused on
retargeting for the JVM and automatic parallelization, but we've experimented a bit with more exotic targets like GPUs, so I'm always
keen to learn more about new architechtures.

Helena Kotthaus spoke on the challenges of parallelization in heterogenous embedded systems ([video](https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/R-goes-Mobile-Efficient-Scheduling-for-Parallel-R-Programs-on-Heterogeneous-Embedded-Systems)) where an R runtime would have access to multiple cores with different capabilities. This would
be interesting challenge to support Renjin's vector pipeliner, which is currently "resource oblivious" when it comes to scheduling
work on the available cores.

On another end of the computing spectrum, Scott Michael shared the results of R benchmarks on Intel's Knight Landing architecture
([video](https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/Performance-Benchmarking-of-the-R-Programming-Environment-on-Knights-Landing)),
where an R runtime in principle has access to 64 cores with 256 threads. Though the benchmarks were mostly limited to linear algebra
benchmarks, it was super interesting to learn more about this architecture. 


# R Language

Even after working on Renjin for several years, I continue to be suprised by the depth and flexibility of the R language.

Lionel Henry presented his work on "fexprs" or symbolic computation during RIOT and the 
[main conference track](https://user2017.sched.com/event/Axoq/programming-with-tidyverse-grammars). We're all familiar
with a specifiying statistical models in R using a formula such as `y ~ 3*x + 1`, but it gets far more complicated when you
start writing functions that parametrize such expressions. It's something I hadn't given alot of thought to, and so it was a real 
eye-opener.

It was also super interesting to hear Radford Neal's proposals for extensions or changes to the R language itself. There are
really *are* some syntactical constructions that trip up R programmers, such as `1:x` or `y[x]` when `x` is negative or empty,
and I think there is tremendous value in finding backward-compatible solutions.

# Profiling

Kirill Müller shared progress on an R Foundation project to improve profiling of R and native code ([video](https://www.youtube.com/watch?v=THgNl-cN7Vc&list=PLIptkSEKleN17z3IAF6Pjc6tU755W67kv&index=2)). I think there's a chance to develop
a common raw output format for profiling tools on which a rich set of analysis tools can be written in R. We added a very basic
profiler to Renjin awhile back, so we'll follow this closely to see if we can also support this common target.

# Graphics

The FastR team from Oracle has made some great progress on supporting graphics in their Graal-based R interpreter 
([video](https://www.youtube.com/watch?v=otXTGBTb-3w&list=PLIptkSEKleN17z3IAF6Pjc6tU755W67kv&index=3)) that I think Renjin
can leverage. After some experimentation, they settled on supporting the grid interface rather than the comparatively low-level
grDevices interface which apparently is very tightly coupled to the GNU R interpreter internals. Their 
[implementation](https://github.com/graalvm/fastr/tree/master/com.oracle.truffle.r.library/src/com/oracle/truffle/r/library/fastrGrid) is open source
and written in Java so might be a good starting point for adding graphics support to Renjin.




