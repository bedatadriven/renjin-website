---
layout: post
author: 
    name: Alex Bertram
lang: en
title: "Introducing GCC-Bridge: A C/Fortran compiler targeting the JVM"
excerpt: GCC-Bridge is a C/Fortran compiler targeting the 
    Java Virtual Machine (JVM) that makes it possible for Renjin to run R 
    packages that include "native" C and Fortran code without sacrificing 
    platform independence.
---

In this post, I wanted to finally give a proper introduction to GCC-Bridge, 
a C/Fortran compiler targeting the Java Virtual Machine (JVM) that makes it
possible for Renjin to run R packages that include "native" C and Fortran code
without sacrificing platform independence.

## Motivation

Supporting R packages with native code is a big deal: 48% of CRAN's 33 MLOC of
code is native code. and so while our ultimate goal is to allow users to write
fast R code without falling back to another language, if we're to be serious
about running existing R packages, then we need a solution for the existing 
native code base.

<figure>
<table>
<thead>
<tr>
<th align="left">Repository</th>
<th align="right">R</th>
<th align="right">C</th>
<th align="right">C++</th>
<th align="right">Fortran</th>
</tr>
</thead>
<tbody>
<tr>
<th align="left">CRAN</th>
<td align="right">17.2</td>
<td align="right">8.8</td>
<td align="right">5.2</td>
<td align="right">1.8</td>
</tr><tr>
<th align="left">BioConductor</th>
<td align="right">2.5</td>
<td align="right">1.8</td>
<td align="right">1.7</td>
<td align="right">0.02</td>
</tr>
</tbody>
</table>
<figcaption>Millions of lines of code (MLOC), excluding blank lines,
within the latest available package version. 
Source: <a href="http://packages.renjin.org/source">packages.renjin.org</a>
</figcaption>
</figure>

But we also wanted a solution that preserved Renjin's advantages over GNU R. 
If we were to try to use JNI to load platform-specific native libraries, 
then we would inherit all of the deployment headaches that we set to solve 
in building Renjin on the JVM, and loose the ability to run on
Google AppEngine and other sandboxed environments.

More troubling, the widespread use of global variables in package native
code would severely complicate Renjin's auto parallization strategies, and 
prevent users from running multiple, concurrent Renjin sessions in the same 
JVM process.

For these reasons, we set out to build GCC-Bridge, a toolchain that could 
compile C, C++, and Fortran sources to pure Java bytecode.

## Bridging GCC and the JVM

GCC-Bridge, as its name implies, builds on the GNU Compiler Collection (GCC),
which has a modular structure designed to support multiple input languages,
including C, C++, and Fortran, and multiple backends targeting, for example,
x86, ARM, MIPs, etc. 

GCC achieves this small miracle by reducing all input languages into a common,
simple intermediate language called 
[Gimple](https://gcc.gnu.org/onlinedocs/gccint/GIMPLE.html). 
GCC performs most of its optimizations on Gimple, before lowering it 
even further to another intermediate language called the 
Register Transfer Language (RTL), which is then handed over to the backends to 
generate actual machine instructions.

For us, Gimple is also a terrific starting point for a compiler targeting the 
JVM. Consider a simple C function which sums an array of double-precision
floating point:

![Side-by-side comparison of C and Gimple, lightly stylized.](/assets/img/gcc-gimple.svg)

All the complexities of C and Fortran are reduced to a simple list of 
statements, with a small number of operations. This is terrific, because
I really, really, didn't want to have to learn Fortran!

GCC-Bridge consists of a 
[small plugin](https://github.com/bedatadriven/renjin/blob/38ffa3833163363fc513c23eda7ebe2dcb75643a/tools/gcc-bridge/gcc-plugin/src/main/c/plugin.c)
for GCC itself, which dumps the optimized gimple out to a JSON file,
one per source file, and a compiler, a Java program which compiles the 
json-encoded Gimple files to Java class files, using the ASM bytecode library.

![High level Overview of GCC and GCC-Bridge](/assets/img/renjin-gcc.svg)

Note that we're not compiling to the Java <em>language</em>. Like Scala or
Clojure, we're targeting the Java <em>Virtual Machine</em>, the virtual
machine original designed for Java but that has its own standard instruction
set.

## Emulating the GNU R C API

GNU R provides several methods for interfacing with native code from R. 

The simplest of these methods, the so-called .C and .Fortran interfaces, 
simply pass the R vectors as double-precision or integer arrays to C or Fortran
functions, which might look like this:

```c
    void kmeans_Lloyd(double *x, int *pn, int *pp, 
                      double *centers, int *pk, int *cl,
	   	              int *pmaxiter, int *nc, double *wss);
```

Renjin has supported this interface for some time, but starting with
version 0.8.x released at the end of last year, we now support the .Call 
interface as well, which involves passing pointers to GNU R internal `SEXPREC`
structures.

The great thing about the GCC-Bridge tool chain is that it gives us the chance
to play with the input sources before compiling them. We use this capability to
map all references to the `SEXPREC` type to Renjin's own Java
interface `org.renjin.sexp.SEXP`, and link all calls to the internal GNU R API 
to [Java methods](https://github.com/bedatadriven/renjin/blob/master/tools/gnur-runtime/src/main/java/org/renjin/gnur/api/Rinternals.java), 
initially [generated](https://github.com/bedatadriven/renjin/blob/master/tools/gnur-compiler/generateStubs.groovy)
from GNU R's own header files.

# Kicking the Tires

GCC-Bridge is an important part of the Renjin toolchain for GNU R packages,
but it can also be used independently of Renjin.

I've put together an example on 
[bedatadriven/gcc-bridge-example](https://github.com/bedatadriven/gcc-bridge-example)
that compiles a [few functions](https://github.com/bedatadriven/gcc-bridge-example/blob/master/src/main/c/pnorm.c)
from R's nmath library and then calls the compiled functions 
[from java](https://github.com/bedatadriven/gcc-bridge-example/blob/master/src/test/java/org/renjin/gcc/example/NormalDistTest.java).

You can fork this repo and use it as a basis for compiling your own C/Fortran
source to Java classes.


Keep in mind that we've worked primarily on compiling scientific code
that does pure computation, so you won't find implementations of many
basic C standard library functions like `fopen()` at this point.

# Next Steps

There's alot of interesting things to talk about, so this will be the first 
post in a series. In subsequent posts, I'll dive into
the compiler's internals and look at how we handle anathmas like pointer
arithmatic and malloc(); I'll explore the performance implications of running C
code on the JVM; and finally I'll review the current limitations of the compiler
and some potential ways forward.








