---
layout: default
title: Renjin's design philosophy
---

Renjin's design philosophy
==========================

Introduction
------------

This is an overview of Renjin's design, a project that is in equal parts a port
and a rewrite of the [R-project](http://www.r-project.org)'s interpreter of the
R Language for Statistical Computing.

The R language and its sole interpreter to date have evolved together over a
period of decades, so any attempt to implement a new interpreter of the R
language without reference (and deference!) to its abrahamic implementation
would be unlikely to succeed. Renjin's core borrows heavily from the original C
code, indeed, many portions remain literal translations from C to Java. 

At the same time, Renjin is attempt to modernize the internals of the
interpreter and to profit from the strengths of the JVM in areas such as
garbage collection, unicode handling and I/O. The latent object-oriented
character of the original SEXP has been expanded to a full-fledged class
hierarchy, and most primitive functions have been written from scratch based
documentation and experimentation with the R repl. 

Front End
---------

The front end of the interpreter/compiler parses R language programs into an
Abstract Syntax Tree (AST).

Renjin's
[lexer](http://code.google.com/p/renjin/source/browse/trunk/core/src/main/java/r/parser/RLexer.java) is ported directly from the C.

Renjin's parser is built from the original
[gram.y](http://www.google.com/codesearch#ph23m5MVwzs/trunk/R-2.10.1-patched/src/main/gram.y&q=package:r4jvm%20file:gram.y&l=1) using the java extension of the [Bison parser
generator](http://www.gnu.org/software/bison/).


Strings and Character Encodings
-------------------------------

Since Renjin implements R character vectors with Java strings, all character
vectors are encoded in UTF-8. 

Base Library
------------

R's 'base' package (as well as other 'recommended' packages) are divided into
portions written in the R-language and 'primitives' written in C/Fortran.

Renjin's uses the R Project's R-language base library without modification.
This help ensures compatibility with the original interpreter and will
facilitate renjin's evolution alongside the C-based interpreter. 

While the native portion of R's base library is huge -- nearly 700 functions
coded in C -- much of the heavy lifting, from linear algebra to regexs, can be
delegating to existing [ThirdParty libraries for the JVM]().

Interpreter
-----------

There are two interpreters under development: the so-called Mark I interpreter (working) and the Mark II jitting interpreter. 

### Mark I

The Mark I is currently used by Renjin and is implemented in the same fashion
as R.2X. The evaluator simply descends the AST recursively evaluating symbols,
function calls, and promises as they are encountered. All control flow
statements are implemented as functions and use exceptions to handle things
like break and return. 

The Mark I interpreter is about 10-30% faster than the original R interpreter
on benchmarks that involve alot of R code. The one big hole is the lack of
optimization around copy-on-write semantics: assigning elements of a vector
sequentially in an array is a bit of performance black hole for the moment. 

### Mark II

The Mark II interpreter is under development. It translates the AST to an
intermediate representation that is more efficent to execute, and will
eventually feature type inference and narrowing (from vectors to scalars) and
just-in-time compilation to byte code. 
