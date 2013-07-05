---
layout: default
title: Contributor guide
---

Introduction
============

This documentation is for people who wish to contribute to the development of
Renjin. This requires a good working knowledge of Java and preferably also in
R. However, Java programming is by far the bulk of Renjin's development.

Renjin's base is meant to be 100% compatible with R base version 2.14.2, but
not all R primitive functions are implemented at the moment. Also, the original
goal of Renjin is to provide R's functionality embedded in other systems
therefore some functionality, like graphics, is not very high on our list of
priorities.

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

As mentioned in the introduction, you should have a good working knowledge of
Java and preferably also R to contribute to Renjin's development. As Renjin is
a Java application, you should install an IDE which supports Java development.
At [BeDataDriven](http://www.bedatadriven.com) we like 
[IntelliJ IDEA](http://www.jetbrains.com/idea/), but you can also use
[Eclipse](http://www.eclipse.org) or any other IDE you like. Also, although you
may be able to build Renjin in Windows, we have only tested the build process
on the Linux operating system.

In the following sections we explain where to get the source code and how to
build Renjin using Maven.

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

At the same time, Renjin is an attempt to modernize the internals of the
interpreter and to profit from the strengths of the JVM in areas such as
garbage collection, unicode handling and I/O. The latent object-oriented
character of the original SEXP has been expanded to a full-fledged class
hierarchy, and most primitive functions have been written from scratch based on
documentation and on experimentation with the R Read-Evaluate-Print-Loop
(REPL), that is the R console. 

Front End
---------

The front end of the interpreter/compiler parses R language programs into an
Abstract Syntax Tree (AST).

Renjin's
[lexer](https://github.com/bedatadriven/renjin/blob/master/core/src/main/java/org/renjin/parser/RLexer.java) is ported directly from the original version written in C.

Renjin's parser is built from the original
[gram.y](http://svn.r-project.org/R/tags/R-2-14-2/src/main/gram.y) using the Java extension of the [Bison parser
generator](http://www.gnu.org/software/bison/).


Strings and Character Encodings
-------------------------------

Since Renjin implements R character vectors with Java strings, all character
vectors are encoded in UTF-8. 

Base package
------------

R's 'base' package (as well as other 'recommended' packages) are divided into
portions written in the R language and 'primitives' written in C or Fortran.

Renjin uses the R Project's R-language base package without modification.
This ensures compatibility with the original interpreter and will
facilitate Renjin's evolution alongside the C-based interpreter. 

While the native portion of R's base package is huge --nearly 700 functions
coded in C-- much of the heavy lifting, from linear algebra to regular
expressions, can be delegating to existing [third-party
libraries](#third-party-libraries-used-by-renjin) for the JVM.


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

The R-Language can be surprising to programmers coming from a background
in C or Java. It is a language rooted in Lisp, flavored by Fortran, and 
continually tweaked by working statisticians for ease of use. 

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

R is a multi-paradigm language (or less charitably, a mess :=). There are at
least three different OOP systems at work:

  * S3 objects: simple, practical, and widely used. 
  * S4 objects: more formal, class-based OOP system. To paraphrase [Lord Palmerston](http://en.wikipedia.org/wiki/Schleswig-Holstein_Question#Schleswig-Holstein_Question_in_literature): "Only three people have ever really understood S4 objects—the Prince Consort, who is dead—a German professor, who has gone mad—and I, who have forgotten all about it."
  * [r-proto](http://code.google.com/p/r-proto/): Prototype-based model of object oriented programming for R programmers.

### Lazy, Impure, Mostly non-strict

Like Haskell, arguments to (most) functions are not evaluated until they are
explicitly referenced. This is called laziness. For example:

    > f <- function(a,b) { if(a > .50) a else b }
    > f(0.75, factorial(100))
    0.75

In the above function call, 0.75 > 0.5, so the argument `b` --the nasty
factorial-- is never evaluated.

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

This section presents an overview of the mapping of R language types to Java
objects. Where possible, we have tried to keep names consistent with the R
Language itself, even if that means deviating from type names used in the
original C code; so we have a ListVector rather than a GenericVector because
that's what an R user sees.

### Hierarchy

![Renjin type hierarchy](https://docs.google.com/drawings/d/13oG0xX0hLdIY9iT471u606RqoDYxjeElwXWfiSBlrqg/pub?w=750&amp;ext=.png)

### Vector Types

------------------------------------------------------------------------------------
**R type name** **Java Class**      **Java element type** **SEXPTYPE in C Sources** 
--------------- ------------------- --------------------- ------------------------- 
list            ListVector          SEXP                  VECSXP                    

expression      ExpressionVector    SEXP                  EXPRSXP                   

logical         LogicalVector       int                   LGLSXP                    

integer         IntVector           int                   INTSXP                    

double          DoubleVector        double                REALSXP                   

complex         ComplexVector       [o.a.c.m.c.Complex]   CPLXSXP 

character       StringVector        java.lang.String      STRSXP                    

------------------------------------------------------------------------------------

[o.a.c.m.c.Complex]: http://commons.apache.org/math/api-2.1/index.html?org/apache/commons/math/complex/Complex.html

#### Immutability

From the R programmer's perspective, vectors are immutable; `x[1] <- 4.2`
actually creates a new object with the first element replaced and assigns this
new element to the current environment. 

In Renjin, this immutability is enforced by the Java classes as well. Each
Vector type has an associated Builder class that can be used to create new
instances or copies of existing instances.

#### Missingness

All AtomicVectors support the concept of missing data: elements can take a
value of NA or "Not Available" which indicates that the data point is missing
(due to data collection error, non-response, etc).

### Function Types

--------------------------------------------------------------------------------------------------
R type name         Java Class          SEXPTYPE in C       Description 
                                        Sources   
------------------- ------------------- ------------------- --------------------------------------
n/a                 Function            FUNSXP              Supertype of all function types.
                                        ("pseudo-type")      

closure             Closure             CLOSXP              A function closure consisting of an 
                                                            enclosing environment, a formal 
                                                            argument list, and a body of 
                                                            statements.

n/a                 PrimitiveFunction   n/a                 A function written in Java.

builtin             BuiltinFunction     BUILTINSXP          A primitive function to which 
                                                            evaluated arguments are passed. 

special             SpecialFunction     SPECIALSXP          A primitive function to which 
                                                            unevaluated arguments are passed. 
                                                            Examples are `if`, `for`, `{`, `c`. 

--------------------------------------------------------------------------------------------------

### Other Types

--------------------------------------------------------------------------------------------------
R type name         Java Class          SEXPTYPE            Description  
                                        in C Sources   
------------------- ------------------- ------------------- --------------------------------------
NULL                Null                NILSXP              The nullary object. Note that this is 
                                                            a different than a null pointer 
                                                            reference; the NULL object has length 
                                                            (=0) and some other properties.

symbol              Symbol              SYMSXP              Symbols 

environment         Environment         ENVSXP              A dictionary-like structure that is 
                                                            analogous to a frame into which local 
                                                            variables are bound, but can also be 
                                                            created and used as hashmap by user 
                                                            code. 

externalptr			ExternalPtr								In GNU R, a simple pointer to 
															some external memory address.
															
															In Renjin, an ExternalPtr is also
															a reference to a JVM object.
															
pairlist            PairList            LISTSXP             A Scheme-style linked list, mainly 
                                                            used internally by the interpreter.

language            FunctionCall        LANGSXP             A function call. Contains a reference 
                                                            to the Function and an argument list. 

_not visible_       Promise             PROMSXP             Holder for lazy-evaluated expressions;
                                                            analogous to a "thunk" in classical 
                                                            lazy languages like Haskell.

?                   CHARSXP             CHARSXP             Wrapper for a single String. This is 
                                                            used internally by the C interpreter, 
                                                            we are evaluating whether we need to 
                                                            keep this in the java implementation.

--------------------------------------------------------------------------------------------------

Execution Modes
===============

The Renjin interpreter is actually composed of three different execution modes in which
an R expression can be evaluated, depending on the type of workload:

1. The "slow" interpreter, modelled closely after GNU-R, and supporting the full 
   range and richness of the R language. 
2. The Just-in-time "vector pipeliner," which constructs optimized, auto-parallelized pipelines for 
   vector and matrix operations on large sets of data
3. The "scalar compiler" which is capable of compiling a subset of the R language
   to highly efficient JVM byte code
   
   
## The Slow Interpreter
   
The slow interpreter, whose entry point is Contex.eval(), simply walks the R Abstract Syntax Tree
at runtime in the same fashion that GNU R does, evaluting symbols and function calls. 

Variables are assigned as elements in the heavyweight `Environment` instance, and each new function
invocation gets its own Environment and a new context. While there are a many -- many -- aspects of this 
interpreter that can still be optimized, from argument matching to variable lookup, it is unlikely 
that this intrerpreter, with all it's flexibility, will likely stay pretty slow.

Instead, Renjin focuses on optimizing workloads that are the most important in statistical computation
and data prepration and analysis. Renjin accomplishes this by _deferring_ real work as much as possible in the slow
interpreter, and by compiling critical paths (sapply, vapply, for) of R to JVM byte code.

## The Vector Pipeliner

Deferring work is possible because Renjin introduces a degree of seperation between data and algorithms:
its builtins (see below) do not operate on raw arrays the way that GNU R does, but rather on instances
of the `Vector` interface.

So when the slow interpreter encounters an R expression like:

```{.R}
  x <- runif(1e6)
  y <- sqrt(x + 1)
  z <- mean(y) - mean(x)
  attr(z, 'comments') <- 'still not actually computed'
  print(length(z)) # prints "1" but doesn't evalute the mean
  print(z)  # triggers computation
```
 
it first _does_ allocate a vector for the sequence of random numbers. However, when we add 1 to this 
vector, it _does not_ allocate a second vector and fill it with `x+1`, but rather returns a sort of "view", 
an implementation of the DoubleVector interface wraps our original vector and simply adds 1 when its elements are requested:

```{.java}
// simplifed for illustration:
interface PlusOneVector extends DoubleVector {
  Vector x;
  
  double getElementAsDouble(int index) {
	return x.getElementAsDouble(index)+1;
  }
  
  int length() {
	return x.length();
  }
}
```

Likewise, our implementation of the mean() function will return a `DeferredMean` instance for suitably
large input.

Note that these views and deferred computations are quite different than GNU R's promises: to the R code, they are 
fully evaluated vectors with a length and attributes; you can pass them around and do just about everything to them
except inspect the value of an element.

When we finally pass it to the print() function, impure and thus non-deferrable, evaluation is triggered for the
arguments.

![Calculation graph](/diagrams/graph1.png)

What we get is a directed acyclic computation graph of all the work we've been putting off. Since we've waited this long,
we're able to parallelize some of this work, executing the two mean calculations concurrently as they are clearly 
independent.

## The Scalar Compiler

TODO


Implementing primitives
=======================

The bulk of the work involved in building Renjin is replacing the 'primitive'
functions that are implemented in C in the original interpreter. Implementing
these functions is also reasonably straightforward, so it's great place to
start.

Quick start
-----------

Implementing primitives is a four-step process:

1. write a test case,
2. implement the function class,
3. register your class with the BaseFrame,
4. write more test cases.

These steps are explained in the following sections.

### Write the test case

Start by writing a test case. Ultimately test cases will be written in R itself,
but the plumbing is not yet there. So for now, you might write a JUnit test
that looks like this:

```{.java}
public class SqrtTest extends EvalTestCase {

  @Test
  public void sqrtFunction()  {
    assertThat( eval("sqrt(4)"), equalTo(c(2)));  
  }
}
```

The `EvalTestCase` provides a simple DSL based on the 
[Hamcrest Matcher library](https://github.com/hamcrest) that makes writing
tests a bit simpler. See
[TypesTest](https://github.com/bedatadriven/renjin/blob/master/core/src/test/java/org/renjin/primitives/TypesTest.java) 
for a good example of how write tests.

Next, place your test in the `src/test/java` folder. Then compile and make sure your test fails as expected. 

### Implement the function class

Renjin has a convenience layer that maps R function calls to Java static
methods, abstracting away many of the messy details of argument checking and
conversion. 

Simply declare your method as a `public static` method in a class in the `r.base` package and use annotations to define 

Here are the implementation of the `is.double` and `match` functions, for example:

```{.java}
@Builtin("is.double")
public static boolean isDouble(SEXP exp) {
  return exp instanceof DoubleVector;
}
```


```{.java}
@Internal
public static IntVector match(AtomicVector search, AtomicVector table, int noMatch, AtomicVector incomparables) {
  //For historical reasons, FALSE is equivalent to NULL.
  if(incomparables.equals( LogicalVector.FALSE ) ) {
    incomparables = Null.INSTANCE;
  }

  IntVector.Builder matches = new IntVector.Builder();
  for(int i=0;i!=search.length();++i) {
    if( incomparables.contains(search, i)) {
      matches.set(i, noMatch);
    } else {
      int pos = table.indexOf(search, i, 0);
      matches.set(i, pos >= 0 ? pos+1 : noMatch;
    }
  }
  return matches.build();
}
```

When `match()` is called from R-code, Renjin will verify that the correct number
of arguments is present, and of the right type, marshall the call to your
static method, and then convert your return value, if necessary to a SEXP.

Renjin also handles 'recycling', which makes it easier to implement methods
that operate on each element of a vector. For example:


```{.java}
@Builtin
@DataParallel
public static double divide(double x, double y) {
  return x / y;
}
```

When called from the R-language, Renjin will call your method for each element
in the vector.

For functions that accept a variable number of arguments (like `c()`), you can
declare your method accordingly:

```{.java}
@Primitive
public static SEXP c(@ArgumentList ListVector arguments,
                     @NamedFlag("recursive") boolean recursive) {
   // implementation here
}
```

For a complete description of Renjin annotations, see 
[Anatomy of a primitive call](#anatomy-of-a-primitive-call) later on in this
guide.

### Register your class with the BaseFrame

Next, you need to tell Renjin where to find your new implementation, by specify
the class in
[org.renjin.base.BaseFrame](https://github.com/bedatadriven/renjin/blob/master/core/src/main/java/org/renjin/base/BaseFrame.java) 
where you'll find a close facimile of
[names.c](http://svn.r-project.org/R/tags/R-2-14-2/src/main/names.c),
except that in place of a function pointer, we use a Java class literal. 

```{.java}
...
f("is.double", Types.class, 0 /*REALSXP*/, 1, 1);
...
```

Renjin will then look for a method with the same name in `Types.class`, or if the
method name is not a valid java identifier, it will look for a method annotated
with `@Builtin("is.double")`.

Then code until your test passes!

### Write more test cases

R gives a lot of flexibility, which means there are a lot of edge cases. You
can look through the C-code implementation, but we have found it easier to
generate test cases by exploring output from the R Read-Eval-Print-Loop. 

Anatomy of a primitive call
---------------------------

When implementing primitives, it helps to understand how primitive functions
are called from R-language code.

A call to a primitive function written in Java begins in one of several ways,
depending on:

* whether the function is 'internal' or not,
* whether the function is generic.

### Non-generic, Non-internal primitives

These are the simplest class of primitives and include functions like `c()`,
`sqrt()`, and `sin()` as well as so-called 'special' functions such as `if`,
`for`, `(` and `{`.

Note: there is a further distinction in the R-language between 'builtin' and
'special' primitives. This distinction is preserved in Renjin but is not so
important for the implementation so we will gloss over it for the moment.

If you enter `c`, `sqrt`, and `sin` (without the brackets) into the R console,
you see the following:

    > c
    function (..., recursive = FALSE)  .Primitive("c")
    > sqrt
    function (x)  .Primitive("sqrt")
    > sin
    function (x)  .Primitive("sin")

You can also inspect 'special' functions by using backquotes:

    > `if`
    .Primitive("if")

(Yes, 'if' is a function in R, and you can redefine it!)

When Renjin evaluates a function call like `sqrt(2)`, it first searches the
current environment and all enclosing environments for a function bound to the
symbol 'sqrt'. Renjin, like R, will _ignore_ any non-functions bound to the
symbol, so the following will still work:

    > sqrt <- 99
    > sqrt(4)
    [1] 2

This is because the expression `sqrt <- 99` assigns the value 99 to the symbol
'sqrt' in the global environment, while the primitive function 'sqrt' is bound
in the base environment. 

You can type `search()` into the console see the heirarchy of enclosing
environments:

    > search()
    [1] ".GlobalEnv"        "package:stats"     "package:graphics" 
    [4] "package:grDevices" "package:utils"     "package:datasets" 
    [7] "package:methods"   "Autoloads"         "package:base"    

A function value in Renjin is simply an object instance which implements the
`Function` interface, which extends the `SEXP` interface with a single method:

```{.java}
public interface Function extends SEXP, Recursive {

  EvalResult apply(Context context, Environment rho, FunctionCall call, PairList args);
}
```

When a function call is evaluated, Renjin simply passes the whole FunctionCall
and the arguments to the apply method. For the simple example of `sqrt(4)`,
this would look like (in psuedo-ish code):

    FunctionCall call = FunctionCall.newCall( 
       new Symbol("sqrt"), 
       PairList.fromArray( new DoubleVector(4) ) );

    Function sqrt = rho.findFunction(call.getFunction());
    sqrt.apply(context, rho, call, call.getArguments());

### Non-generic, internal primitives

As convenience to the original R developers, some primitive functions were
split between an R-language closure located in the base library, and an
'internal' function written in C -- and now in Java within Renjin. 

The outer R-language function is generally responsible for matching, converting
and validating arguments (which is easier to do in the R-language than in C) and
providing default values for arguments.

For example, the function `grep` is defined as an R-language closure in the
base package:

    > grep
    function (pattern, x, ignore.case = FALSE, perl = FALSE, value = FALSE, 
        fixed = FALSE, useBytes = FALSE, invert = FALSE) 
    {
        if (!is.character(x)) 
            x <- structure(as.character(x), names = names(x))
        .Internal(grep(as.character(pattern), x, ignore.case, value, 
            perl, fixed, useBytes, invert))
    }

After performing any necessary convertions, and relying on R for matching
arguments by name, it calls into the internal primitive `grep` function, which
only matches arguments positionally. 

Note that if we were to start Renjin completely from scratch, this might not 
be the best approach; it might be cleaner to move certain functions completely
to Java or to R to avoid these akward dependencies; but for the moment we want
to reuse as much as GNU's R-language packages as possible. These are huge,
complex packages, and the more we can keep the better. So for the moment we are 
replacing the internal functions written in C with Java implementations so that
we remain source-level compatible. 

From a primitive-function implementor's perspective, there is no difference
between an internal and non-internal function; the `.Internal` function is
responsible for locating the internal function within a special part of the
base frame and calling its `apply()` method. 

Both internal and non-internal functions are expected to implement the Function
interface.

When implementing an internal function, however, you must be careful to find
the signature from the R language closure or the C implementation: the standard
R docs describe the signature and behavior of the outer R-language closure, not
the internal function itself.


### Generic primitives

The R language defines a simple form of object-oriented design called 'S3
generics', which involve choosing a function based on the class attribute of
its arguments.

For example, look at the `mean` function:

    > mean
    function (x, ...) 
    UseMethod("mean")
    <environment: namespace:base>

When you evaluate `mean(x)`, the special `UseMethod()` function will check the
class of the argument and look, in order of priority, for a function called
`mean.class1`, `mean.class2`, ... `mean.default`.

For example:

    > x <- 1:42
    > class(x) <- c('blaz', 'foo') 
    > mean.foo <- function(x) -99
    > mean(x)
    99

Many of the functions in the base package are generic, and so you will often
only find the call to the primitive in the `xxx.default` function.

The `mean` primitive, for example, is only called by the `mean.default`
function after some preprocessing in the R-language closure (see the
`.Internal(mean(x))` call at the very end of `mean.default()`):

    > mean.default
    function (x, trim = 0, na.rm = FALSE, ...) 
    {
        if (!is.numeric(x) && !is.complex(x) && !is.logical(x)) {
            warning("argument is not numeric or logical: returning NA")
            return(NA_real_)
        }
        if (na.rm) 
            x <- x[!is.na(x)]
        if (!is.numeric(trim) || length(trim) != 1L) 
            stop("'trim' must be numeric of length one")
        n <- length(x)
        if (trim > 0 && n) {
            if (is.complex(x)) 
                stop("trimmed means are not defined for complex data")
            if (any(is.na(x))) 
                return(NA_real_)
            if (trim >= 0.5) 
                return(stats::median(x, na.rm = FALSE))
            lo <- floor(n * trim) + 1
            hi <- n + 1 - lo
            x <- sort.int(x, partial = unique(c(lo, hi)))[lo:hi]
        }
        .Internal(mean(x))
    }
    <environment: namespace:base>

This is relevant to Renjin contributors because the closure above is
essentially the specification of the `mean` primitive; the R language
documentation refers to the outer function.

Implementing primitives directly
--------------------------------

In Renjin, a primitive function is simply a (JVM) object which implements the
Function interface. This is how several special functions are implemented in
Renjin, including the `if` function.

> In the R language, `if` is simply a function that takes up to three
arguments: `condition`, `ifTrueExpr`, `ifFalseExpr`. Normally, you would use
the special syntax `if(condition) ifTrueExpr else ifFalseExpr` but this is only
syntactic sugar; you can also call the function directly using backquotes ``
`if`(condition, ifTrueExpr, ifFalseExpr)``. 

Renjin's implementation is found in
[org.renjin.primitives.special](https://github.com/bedatadriven/renjin/blob/3829886b3d81ea5ebe8dd1b14489698981a79c0a/core/src/main/java/org/renjin/primitives/special/IfFunction.java):

```{.java}
public class IfFunction extends SpecialFunction {

  public IfFunction() {
    super("if");
  }

  @Override
  public SEXP apply(Context context, Environment rho, FunctionCall call, PairList args) {
    SEXP condition = context.evaluate( call.getArguments().getElementAsSEXP(0), rho);

    if (asLogicalNoNA(context, call, condition)) {
      return context.evaluate( call.getArguments().getElementAsSEXP(1), rho); /* true value */

    } else {
      if (call.getArguments().length() == 3) {
        return context.evaluate( call.getArguments().getElementAsSEXP(2), rho); /* else value */
      } else {
        context.setInvisibleFlag();
        return Null.INSTANCE;   /* no else, evaluates to NULL */
      }
    }
  }
}
```

You can say that this implementation takes full responsibility for the
application of the function. It matches its arguments, evaluates them according
to the semantics of the function (`condition` is always evaluated, `ifTrueExpr`
is only evaluated if `condition` is true, etc.) and explicitly sets the
visibility flag of its return value.

This is fine for the `if` function; argument matching is strictly positional
(it doesn't take argument names into the account the way
`c(x,y,recursive=TRUE)` does) and the logic is simple.

There are, however, nearly 700 primitives to implement, and many of these
functions have complicated argument matching semantics. If you look at the 
[C implementation](http://svn.r-project.org/R/tags/R-2-14-2/src/main/grep.c)
of a function like `grep`, there are nearly 40 lines of code dedicated to
matching and converting arguments. 

Implementing primitives with annotations
----------------------------------------

Renjin uses a combination of @Annotations and code generation in place of
hand-written argument-processing code. This is intended to have serveral
advantages:

* Primitives are faster to write;
* Resulting code is cleaner, easier to read;
* Less code to maintain;
* Optimizations can be written once into the code-generation layer and applied to all functions.

In addition to argument processing, there are a number of other 'aspects' that
this code-generation layer handles transversely, including:

* Recycling (application of functions to all elements of vectors);
* Generic and group generic dispatching.

When using annotations, you define your implementation as a `public static`
method:

```{.java}
@Internal
public static Vector grep(
    String pattern,
    StringVector x,
    boolean ignoreCase,
    boolean value,
    boolean perl,
    boolean fixed,
    boolean useBytes,
    boolean invert) {
    
   /* ... */
 }
```
 
At compile time, Renjin will generate a class implementing the Function
interface based on the signature of your method and any annotations that apply
to the method or its arguments. The 'wrapper class' for the function above
looks like this:

```{.java}
public class R$primitive$grep extends BuiltinFunction {

  public R$primitive$grep() { super("grep"); }

  @Override
  public EvalResult apply(Context context, Environment rho, FunctionCall call, PairList args) {
    try {;
      ArgumentIterator argIt = new ArgumentIterator(context, rho, args);

      SEXP s0 = argIt.next().evalToExp(context,rho);
      java.lang.String arg0;
      arg0 = convertToString(s0);
      SEXP s1 = argIt.next().evalToExp(context,rho);
      r.lang.StringVector arg1;
      try {
        arg1 = (r.lang.StringVector)(s1); 
      } catch(ClassCastException cce) { 
        throw new ArgumentException(); 
      };
      SEXP s2 = argIt.next().evalToExp(context,rho);
      boolean arg2;
      arg2 = convertToBooleanPrimitive(s2);
      SEXP s3 = argIt.next().evalToExp(context,rho);
      boolean arg3;
      arg3 = convertToBooleanPrimitive(s3);
      SEXP s4 = argIt.next().evalToExp(context,rho);
      boolean arg4;
      arg4 = convertToBooleanPrimitive(s4);
      SEXP s5 = argIt.next().evalToExp(context,rho);
      boolean arg5;
      arg5 = convertToBooleanPrimitive(s5);
      SEXP s6 = argIt.next().evalToExp(context,rho);
      boolean arg6;
      arg6 = convertToBooleanPrimitive(s6);
      SEXP s7 = argIt.next().evalToExp(context,rho);
      boolean arg7;
      arg7 = convertToBooleanPrimitive(s7);
      SEXP s8 = argIt.next().evalToExp(context,rho);
      boolean arg8;
      arg8 = convertToBooleanPrimitive(s8);

      // make call
      return wrapResult(r.base.Text.grep(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));

    } catch (r.jvmi.wrapper.ArgumentException e) { 
      throw new EvalException("Invalid argument. Expected:\n\tgrep(character(1), character, logical(1), logical(1), logical(1), logical(1), logical(1), logical(1), logical(1))");
    } catch (java.lang.RuntimeException e) { 
      throw e;
    } catch (java.lang.Exception e) { 
      throw new r.lang.exception.EvalException(e);
    }
  }
}
```

These wrapper classes are generated by the `r.jvmi.WrapperGenerator` class and
are written to the `core/target/generated-sources/r-wrappers` folder. 

### Data Parallel Functions

One of R's greatest strengths is that it provides a large class of what you
might call "Data Parallel" function, which apply the same computation to all
elements in a vector: `sqrt(4) == 2` and `sqrt(c(4,9,16)) == c(2,3,4)`.

Implementing such functions require attention to several semantic aspects:

* **Recycling of arguments:** for example, in the function call `c(1,2,3,4) ==
  c(1,2)`, the argument `1` should be recycled once so that it is treated like
  `c(1,2,1,2)`, matching the length of the longest argument. `c(1,2,3,4) ==
  c(1,2,3)` is considered an error because the length of the shorter vector is
  not a multiple of the longer vector (though in most non-math functions this is
  ignored).

* **Copying of attributes:** depending on the function, all, some, or no
    attributes are copied from the longest argument to the result.  `names(sqrt(x))
    == names(x)`, for example.

Since these are aspects which apply transversely to a large class of functions,
Renjin attempts to push these concerns down into the code generation layer. 

Given the declaration:

```{.java}
@Deferrable
@Builtin("*")
@DataParallel(PreserveAttributeStyle.ALL)
public static double multiply(double x, double y) {
  return x * y;
}
```

Renjin will generate a wrapper that handles all the recycling, attribute
copying and so forth. See an example of the output 
[here](https://gist.github.com/1197723).

To declare your method as recyclable, you must:

* annotate the method or arguments with `@DataParallel` and
* return a scalar type.
 
If you annotate the method with `@DataParallel`, all arguments of scalar type will
automatically be considered eligible for recycling. If you do not want to permit
recycling on a given argument (it should be fixed to the same value for computations
on all elements), then you can annotate the argument with @Recycle(false)

For example, in the declaration below, the `lowerTail` and `logP` arguments are
_not_ recycled; only the first element is used. 

```{.java}
public static double pbeta(double q, double shape1, double shape2, 
                           @Recycle(false) boolean lowerTail, 
						   @Recycle(false) boolean logP) ;
```

### Scalar Types

For the purposes of code generation, scalar types are defined as:

-------------------------------
Vector Type   Scalar types     
------------- -----------------
LogicalVector boolean, Logical 

RawVector     Raw, byte        

IntVector     int              

DoubleVector  double           

ComplexVector Complex          

StringVector  String           

-------------------------------

If a method is marked as @DataParallel, then Renjin will loop over each element
in the argument vectors, invoking your method for each element, and combining 
the results into an new (Double|Integer|Logical|String)ArrayVector.

### NA Handling

By default, if an argument tuple contains an `NA` value, the result of the
function is considered to be `NA` and your method is not called.

If your method is prepared to explicitly handle `NA` values, you should
supply `passNA = true` to `@DataParallel`. For example:

```{.java}
@Deferrable
@Builtin("&")
@DataParallel(passNA = true)
public static Logical and(double x, double y) {
  if(x == 0 || y == 0) {
    return Logical.FALSE;
  } else if(DoubleVector.isNA(x) || DoubleVector.isNA(y)) {
    return Logical.NA;
  } else {
    return Logical.TRUE;
  }
}
```

TODO: strict vs non-strict recycling.

### Contextual Arguments

Some functions may require access to the current evaluation context and/or
environment. You can indicate to the code generation layer that these are
needed by annotating them with `@Current` as is shown in the next example:

```{.java}
@Internal("R.home")
public static String getRHome(@Current Session session) throws URISyntaxException {
  return session.getHomeDirectory();
}
```

The Session class basically corresponds to a GNU R process, and holds all global
state common to a given R "session." In this way, multiple sessions can coexist 
within the same Java Virtual Machine process, allowing a web server, for example, to
handle concurrent requests with different R sessions running on different threads.

A call to R.home(), for example, is evaluated in the context of the _current_ session.


### Overrides

As a function implementor, you can provide multiple overloads of a function,
and the generated wrapper will choose the matching method at runtime.

For example:

```{.java}
@Builtin
public static Environment asEnvironment(Environment arg) {
  // ...
}

@Builtin("as.environment")
public static Environment asEnvironment(@Current Context context, int pos) {
  // ...
}

@Builtin("as.environment")
public static Environment asEnvironment(@Current Context context, String name) {
  // ...
}

@Builtin("as.environment")
public static Environment asEnvironment(ListVector list) {
  // ...
}

@Builtin("as.environment")
public static Environment asEnvironment(S4Object obj) {
  // ...
}
```

### Generic Dispatch

While some primitives like `mean` and `print` are called within the context of
the normal S3 dispatch semantics, some primitives, including `[`, `[[`,
`as.character`, `as.raw`, etc, dispatch `exceptionally` from within their body.
That is, after being called, but before they go forward with their own logic,
they check if their argument is an object (that is, it has a non-empty class
attribute) and if there exists a matching function.

This behavior is activated by the `@Generic` and `@GroupGeneric` annotations.



Third-party libraries used by Renjin
====================================

To the extent possible, Renjin should focus on the specifics of the R language
an delegate 'substantive' work to existing specialist libraries for the JVM.

This will help us get to a quality implementation of the R language faster, and
allow Renjin to benefit from innovation and activity of wider communities.

> We think it is preferable to include third party libraries as external
> dependencies (jars) so that Renjin can benefit from subsequent releases, but in
> some cases it may be worth including the source code directly into Renjin's
> codebase:
> 
>  * If the library is not packaged or no longer actively maintained;
>  * If modifications are required for R that would not be of interest to the library's owner.

This document catalogs the libraries used by Renjin and details for
contributors on how to reference them from R primitive implementations.

Libraries
---------

### Math

There are several existing libraries for the JVM that should provide most of
the heavy lifting:

#### LAPACK

[LAPACK and BLAS](http://www.netlib.org/lapack/) are linear algebra libraries,
used by the original R interpreter, which have been compiled to
[JVM byte code](http://www.netlib.org/java/f2j/). 

Renjin uses the [netlib-java](https://github.com/fommil/netlib-java/) API to
allow users to drop in natively optimized versions (like
[ATLAS](http://math-atlas.sourceforge.net/)) for a production environment before
falling back to the JVM byte code version of the library.

LAPACK's API is somewhat obscure, but fortunately it is identical to that used
by the original R interpreter, so in most cases it is best to port the wrapper
functions from the original  directly. See R's 
[src/modules/lapack/Lapack.c](http://svn.r-project.org/R/tags/R-2-14-2/src/modules/lapack/Lapack.c).

#### Commons Math

[Apache Commons Math](http://commons.apache.org/math/) provides a wide array of
functionality, including probability and statistics. 

The `CommonsMath` class provides a few utility routines to bridge the Renjin
and commons API's, particularly with reference to Common's `RealMatrix`
interface.

#### Other math libraries

There are a number of math functions in R's base library that are not provided
by either LAPACK or Commons Math (non-central probability distributions, for
example), so it may be necessary to add additional math libraries at some
point. 

### File System

Many existing R packages are built around direct access to a file system.
Because Renjin is designed to run in environments where this may not be the
case, the basic file operations (`file.info`, `list.files`, `gzfile`, etc.) are
implemented over the 
[Apache Commons Virtual File System (VFS)](http://commons.apache.org/vfs/), 
which allows users to plug in alternative implementations. 

In addition to the 
[many packaged plugins](http://commons.apache.org/vfs/filesystems.html), 
there are implementations for AppEngine, the
[Hadoop Distributed File System](http://timurlaykov.blogspot.com/2011/04/i-found-great-plugin-for-apache-commons.html), and 
[Amazon S3](http://code.google.com/p/vfs-s3/).

### Other

* Regular expression implementation is based on the
  [Jakarta Regexp library](http://jakarta.apache.org/regexp/index.html), which has
  been repackaged into the `org.renjin.primitives.text.regex` package with minor modifications to
  accommodate R syntax.

* LZMA compression implementation provided by the
  [7-zip SDK](http://www.7-zip.org/sdk.html), repackaged into
  `r.base.compression.lzma`.

* BZ2 implementation by Keiron Liddle, via the Ant project, repacked into
  `r.base.compression.bz2`

* Sprintf implementation based on 
  [this article](http://java.sun.com/developer/technicalArticles/Programming/sprintf/), 
  adapted for R.

* Beanshell's swing-based REPL is copied into Renjin's sample 'desktop' REPL.


