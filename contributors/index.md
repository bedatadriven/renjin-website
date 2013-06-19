---
layout: default
title: Contributor guide
---

Introduction
============

This documentation is for people who wish to contribute to the development of Renjin.

Filing a bug report
-------------------

The project currently uses the issue tracker on the Google Code project page:
<https://code.google.com/p/renjin/issues/list>.

Getting help
------------

The best way to get help is to send a question to the (public) mailing list via 
<mailto:renjin-dev@googlegroups.com>. The mail archive is accessible via Google
Groups at <http://groups.google.com/group/renjin-dev>.

Development environment
=======================

TODO

Code repositories
-----------------

The main code repository is hosted at Github and can be found at
<https://github.com/bedatadriven/renjin>. Renjin was originally hosted on Google
Code and the repository at <https://code.google.com/p/renjin/> is regularly
synced with the main repository at Github.

To get started with the latest version of the code, clone the Github repository
using

    git clone https://github.com/bedatadriven/renjin.git

Building from source
--------------------

Renjin's build is organized by Maven 3.x. Download and install Maven from 
<http://maven.apache.org/download.cgi>

In addition to the standard Java tools, Renjin relies on a GCC-based build
chain to compile C/Fortran math routines to JVM byte code.  These tools are in
the early stages of development and are a bit sensitive to different versions
of GCC and to OS. 

If your platform is not listed below, you may need to experiment a bit or ask
for help on the mailing list (see below).

### Ubuntu 12+

You can install GCC and friends through the APT package manager:

    sudo apt-get install build-essential gcc-4.6-plugin-dev gfortran

If you are using a 64-bit version of Ubuntu, you will need to install
additional libraries in order to have GCC cross compile to 32-bits (Renjin uses
JVM arrays to back pointers, and the JVM limits array indices to 32-bits on all
platforms)

    sudo apt-get install gcc-multilib
  
### Fedora 17

Fedora 17 comes with GCC 4.7 which is **not** yet working with Renjin.

    sudo yum install gcc gcc-plugin-devel gcc-gfortran
  
If you're running 64-bit Fedora, you will need the i686 libraries for cross
compiling:

    sudo yum install glibc.i686 glibc-devel.i686

Renjin's design
===============

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

Preliminaries
=============

This is an intro to the R language from the perspective of compiler/interpreter
developers. There are many great intros to R for use in data analysis; this
section is about R as language.

R derives its strength from the flexible, ad-hoc manner in which it has evolved
to meet the real-world needs of its users. As such, there is no definitive
language specification, but the R Project provides two documents that are
nonetheless invaluable:

* [The R language definition](http://cran.r-project.org/doc/manuals/R-lang.html)
* [The R internals manual](http://cran.r-project.org/doc/manuals/R-ints.html)  

Also, the work-in-progress book [Advanced R development: making reusable
code](https://github.com/hadley/devtools/wiki) is becoming a good resource on
some of the programming aspects of R. 

Characteristics of the R Language
---------------------------------

### Functional

Above all, R is functional. Functions are not only first-class citizens in R,
they have a license to kill. 

You can define closures, pass functions around as values, compose them, and
make a nice curry with the right syntax.

But you can do that in Javascript too. R, however, goes a few steps further.
Even control structures are functions. In the given code snippet, for example:

```{.r}
f <- function(x, ...) {
  y <- x * 2
  while( (y+2) > 9 ) {
     y <- y*2
     if(y < 0) break
  }
  return(y)
}
```

the `if`, `{`, `(`, `<-`, `while`, `break` and `function` are all functions.
They are granted special status only by the parser, which translates certain
syntactic structures into function calls. 

You can call or redefine these functions directly by enclosing the symbol in
backquotes. For example, the code below will redefine the `if` function to
evaluate to "Turkey!!" regardless of its arguments (this not actually something
you want to use).

    > `if` <- function(...) "Turkey!!"
    > if(TRUE) 1 else 0 
    [1] "Turkey!!"

### Object-Oriented

R is a multi-paradigm language. (or less charitably, a mess :=) 

There are at least three different OOP systems at work:

  * S3 objects: simple, practical, and widely used. 
  * S4 objects: more formal, class-based oop system. To paraphrase [Lord Palmerston](http://en.wikipedia.org/wiki/Schleswig-Holstein_Question#Schleswig-Holstein_Question_in_literature): "Only three people have ever really understood S4 objects—the Prince Consort, who is dead—a German professor, who has gone mad—and I, who have forgotten all about it."
  * [r-proto](http://code.google.com/p/r-proto/): Prototype-based model of object oriented programming for R programmers.

### Lazy, Impure, Mostly non-strict

Like Haskell, arguments to (most) functions are not evaluated until they are
explicitly referenced. This is called laziness. For example:

    > f <- function(a,b) { if(a > .50) a else b }
    > f(0.75, factorial(100))
    0.75

In the above function call, 0.75 > 0.5, so b is never evaluated and our we
don't bother to evaluate the nasty factorial.

Unlike Haskell or its cousins, which go to great lengths to balance their zany
laziness with a draconian disdain for side-effects, R has no scruples when it
comes to launchMissile()-style effects.

Functions can throw exceptions (called 'conditions', more on that later),
engage in unprotected I/O, or reach into the calling function and change its
state:

    > f <- function()  assign("x", 42, envir=parent.frame())
    > g <- function() { f(); return(x) }
    > g()
    42

Overview of the type system
---------------------------

This section presents an overview of the mapping of R-language types to Java
objects. Where possible, have tried to keep names consistent with the R
Language itself, even if that means deviating from type names used in the
original C code; so we have a ListVector rather than a GenericVector because
that's what an R user sees.

### Hierarchy

![Type hierarchy](https://docs.google.com/drawings/pub?id=13oG0xX0hLdIY9iT471u606RqoDYxjeElwXWfiSBlrqg&w=750&ext=.png)

### Vector Types

**R type name** **Java Class**      **Java element type** **SEXPTYPE in C Sources** 
--------------- ------------------- --------------------- ------------------------- 
list            ListVector          SEXP                  VECSXP                    
expression      ExpressionVector    LangExp               EXPRSXP                   
logical         LogicalVector       int                   LGLSXP                    
integer         IntVector           int                   INTSXP                    
double          DoubleVector        double                REALSXP                   
complex         ComplexVector       [o.a.c.m.c.Complex]   CPLXSXP 
character       StringVector        java.lang.String      STRSXP                    

[o.a.c.m.c.Complex]: http://commons.apache.org/math/api-2.1/index.html?org/apache/commons/math/complex/Complex.html

#### Immutablility

From the R programmer's perspective, vectors are immutable; `x[1] <- 4.2`
actually creates a new object with the first element replaced and assigns this
new element to the current environment. 

In renjin, this immutability is enforced by the Java classes as well. Each
Vector type has an associated Builder class that can be used to create new
instances or copies of existing instances.

#### Missingness

All AtomicVectors support the concept of missing data: elements can take a
value of NA or "Not Available" which indicates that the data point is missing
(due to data collection error, non-response, etc).

### Function Types

**R type name**  **Java Class**    **SEXPTYPE in C Sources**   **Description** 
---------------  ----------------- --------------------------- -----------------------------------------------------------------------------------------------------------
n/a              Function          FUNSXP ("psuedo-type")      Supertype of all function types 
closure          Closure           CLOSXP                      A function closure consisting of an enclosing environment, a formal argument list, and a body of statements 
n/a              PrimitiveFunction n/a                         a function written in Java 
builtin          BuiltinFunction   BUILTINSXP                  a primitive function to which evaluated arguments are passed. 
special          SpecialFunction   SPECIALSXP                  a primitive function to which unevaluated arguments are passed. Examples `if`, `for`, `{`, `c`. 

### Other Types

**R type name**     **Java Class**      **SEXPTYPE in C Sources**   **Description** 
------------------- ------------------- --------------------------- ------------------------------------------------------------------------------------------------------
NULL                Null                NILSXP                      The nullary object. Note that this is a different than a null pointer reference; the NULL object has length (=0) and some other properties.
symbol              Symbol              SYMSXP                      Symbols 
environment         Environment         ENVSXP                      A dictionary-like structure that is analogous to a frame into which local variables are bound, but can also be created and used as hashmap by user code 
pairlist            PairList            LISTSXP                     A Scheme-style linked list, mainly used internally by the interpreter 
language            FunctionCall        LANGSXP                     A function call. Contains a reference to the Function and an argument list. 
_not visible_       Promise             PROMSXP                     Holder for lazy-evaluated expressions; analogous to a "thunk" in classical lazy languages like Haskell 
?                   CHARSXP             CHARSXP                     Wrapper for a single String. This is used internally by the C interpreter, still trying to see whether we need to keep this in the java implementation 
