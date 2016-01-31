---
layout: post
author: 
    name: Alex Bertram
lang: en
title: "Introducing GCC-Bridge: A C/Fortran compiler targeting the JVM"
---

In this post, I wanted to finally give a proper introduction to GCC-Bridge, 
a C/Fortran compiler targeting the Java Virtual Machine (JVM) that makes it
possible for Renjin to run R packages that include "native" C and Fortran code
without sacrificing platform independence.


# Goals

The primary motivation behind Renjin is to allow existing R packages to be used
more broadly; to make it simple to take a predictive model, for example, rapidly
developed in R and deploy it as part of a web application or a "production" 
batch analysis pipeline. 

However, if you're serious about running existing R packages, then you must
deal with the reality that a large of fraction of R packages are actually
written in Fortran, C and C++. 

In principle, it would be possible to use the Java Native Interface (JNI)
to load the native shared libraries, but then we would loose many of Renjin's 
advantages. Renjin would no longer be fully useable in sandboxed environments
like Google AppEngine or Heroku, and because many packages use global variables,
it would no longer be safe to run multiple Renjin sessions in multithreaded
environments like a web server.

For these reasons, we have focused on building a tool chain that can compile
existing C and Fortran sources to JVM bytecode that can be then loaded 



# Bridging GCC and the JVM

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
statements, with a small number of operations. 

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

# Kicking the Tires

GCC-Bridge is an important part of the Renjin toolchain for GNU R packages,
but it can also be used independently of Renjin.

You can find an example here:
https://github.com/bedatadriven/gcc-bridge-example



# Next Steps

There's alot of interesting things to talk about, so this will be the first 
post in a series. In subsequent posts, I'll dive into
the compiler's internals and look at how we handle anathmas like pointer
arithmatic and malloc(); I'll explore the performance implications of running C
code on the JVM; and finally I'll review the current limitations of the compiler
and some potential ways forward.








