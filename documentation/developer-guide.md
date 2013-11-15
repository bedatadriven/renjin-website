---
layout: default
title: Java Developer's guide
---

Introduction
============

This guide intended for Java developers who wish to call R code from a Java 
application, webserver, or other project.

The approach is generally the same for other JVM languages such as Scala,
Clojure, JRuby, etc, but users of those languages will need to make some mental
translation from Java syntax to their own.

Before we start, it is good to realize that in these examples we are not
*calling R* as in GNU R. Technically, we have statements written in the
syntax of the R programming language and we are executing these statement using
the interpreter provided by Renjin. This is what makes Renjin different
from packages like [rJava](http://www.rforge.net/rJava/) and
[rcaller](https://code.google.com/p/rcaller/). 


Setting up a Java project for Renjin
------------------------------------

To invoke R code or packages via Renjin requires the Renjin Script Engine and its
dependencies to be on the classpath. This varies slightly depending on how you
organize your project.


### Eclipse/IntelliJ Project

If you just want to get something up and running quickly in an IDE, you can download
the renjin-script-engine-with-dependencies.jar and place it into your project's lib folder.

TODO: Link to artifacts

### Maven Projects

For projects organized with Apache Maven, you can simply add Renjin as dependency to
your project.

TODO: Link to example


Evaluating R language Code
--------------------------

The best way to call R from Java is to use the 
[javax.scripting](http://docs.oracle.com/javase/6/docs/technotes/guides/scripting/programmer_guide/) 
interfaces. These interfaces are mature and guaranteed to be stable regardless 
of how Renjin's internals evolve.

You can create a new instance of a Renjin ScriptEngine using the ScriptEngineManager class.

    import javax.script.*;

    ScriptEngineManager manager = new ScriptEngineManager();
    ScriptEngine engine = manager.getEngineByName("Renjin");
    if(engine == null) {
        throw new RuntimeException("renjin-script-engine.jar or its dependencies cannot be found on the classpath. ");
    }


Unfortunately, ScriptEngineManager.getEngineByName() silently returns null if there
are any exceptions encountered during the instantation of Renjin's ScriptEngine, so
you will want to check the return result and throw your own more informative exception
should the creation fail.

With the ScriptEngine instance in hand, you can now evaluate R langauge source
code, either from a String, or from a Reader interface. The following snippet, for example,
constructs a data frame, prints it out, and then does a linear regression on the two values.

```{.java}
   engine.eval("df <- data.frame(x=1:10, y=(1:10)+rnorm(n=10))");
   engine.eval("print(df)");
   engine.eval("print(lm(y ~ x, df))");
```
   
You should get the following output on stdout:

```
      x      y
   1  1      0.307
   2  2      3.215
   3  3      1.436
   4  4      3.647
   5  5      5.171
   6  6      6.225
   7  7      6.689
   8  8      7.929
   9  9      9.359
  10 10     11.017

  Call:
  lm(formula = y ~ x, data = df)

  Coefficients:
  (Intercept) x
  -0.569       1.103
   
 Note that the ScriptEngine won't print everything to standard out like
 the interactive REPL does, so if you want to output something, you'll need
 to call print() explicitly.
``` 

Moving data between Java and R code
-----------------------------------

Of course, you'll probably want to do more than just print results to
the console.

Using the javax.script API, you can retrieve the results of R calculations
as Java objects and provide data to R scripts as function arguments or 
as variables.
 
### Passing values from Java to R

We can expand on the previous example by passing in the x and y values
used in the regression from Java rather than hardcoding them. You can do
this by setting variables in the global R environment, or by wrapping your
R script in a function to which you can pass arguments. 

Finally, you can expose larger or more complex data from Java by writing 
wrappers that give access to 

#### Setting variables in the Global Environment

Like many dynamic languages, R scripts are evaluted in the context of an environment
that looks a lot like a dictionary.

You can define new variables in this environment using the javax.script API:

```{.java}
engine.put("age", new double[]    { 1,   2,   3,    4,    5,    6,    7,    8,    9,    10 });
engine.put("height", new double[] { 3.1, 6.4, 8.5,  12.1, 15.4, 17.8, 20.0, 25.3, 27.2, 34.0 });
engine.eval("df <- data.frame(x=age, y=height");
engine.eval("print(lm(y ~ x, df))");
```

### Accessing the results of R calculations from Java

The `engine.eval()` function returns an object of type `SEXP` which can be
casted to a `Vector`. These are Renjin's representations of R language
types. The section
'[Overview of the type system](/documentation/contributor-guide.html#overview-of-the-type-system)'
 in the contributor guide explains these objects in detail. We change
`SampleScript.java` to look like the following:

```{.java}
import javax.script.*;
import org.renjin.sexp.*; // <-- import Renjin's object classes

public class SampleScript {
  public static void main(String[] args) throws Exception {
    // create a script engine manager
    ScriptEngineManager factory = new ScriptEngineManager();
    // create a Renjin engine
    ScriptEngine engine = factory.getEngineByName("Renjin");
    // evaluate R code from String, cast Object to an org.renjin.sexp.Vector and store in the 'res' variable
    Vector res = (DoubleVector)engine.eval("a <- 2; b <- 3; a*b");
    System.out.println("The result of a*b is: " + res.getElementAsDouble(0));
  }
}
```

Note that we need to import Renjin's object types and that we need to cast the
output of `engine.eval()` to the desired type. 

See the next 

### Running R scripts from Java

If we have a large number of R expressions to evaluate, then it's more
practical to store these in a file, i.e. an R script. Let's transfer the previous R expressions to a file `script.R`:

```{.r}
# script.R
a <- 2
b <- 3
a*b
```

Store this file in the `root` directory so our directory layout is now as follows:

    root/
    |
    |_ SampleScript.java
    |_ script.R
    |
    |_ libs/
       |
       |_ renjin-script-engine-{{ site.renjin-current }}-jar-with-dependencies.jar

To run this script from our Java application we change `SampleScript.java` to
use `java.io.FileReader` to read a character stream from a file:

```{.java}
import javax.script.*;
import org.renjin.sexp.*;

public class SampleScript {
  public static void main(String[] args) throws Exception {
    // create a script engine manager
    ScriptEngineManager factory = new ScriptEngineManager();
    // create a Renjin engine
    ScriptEngine engine = factory.getEngineByName("Renjin");
    // evaluate R code in a script on disk
    DoubleVector res = (DoubleVector)engine.eval(new java.io.FileReader("script.R"));
    System.out.println("The result of a*b is: " + res);      
  }
}
```

If we compile and run this application we get exactly the same result as
before. 

### Advanced use of R from Java

**TODO:** add some more examples on how to include R code in Java packages
(maybe find a better title for this section as well)

Importing Java classes in R
---------------------------

**TODO:** the following material is converted from the Google code wiki.
Change/add if necessary.

Renjin introduces the `import()` function which adds a java class to the
environment from which it is called. 

For example:

```{.r}
import(java.util.HashMap)

ls(HashMap)  # lists the static members of the HashMap class

ageMap <- HashMap$new()  # creates a new instance of the HashMap class

ls(ageMap)  # lists instance member

# call methods on the new instance
ageMap$put("Bob", 33)
ageMap$put("Carol", 41)

print(ageMap$size()) 

age <- ageMap$get("Carol")

typeof(age) # java primitives and their boxed types 
            # are automatically converted to R vectors
 
```

### Bean classes

For Java classes with accessor methods that conform to the getXX(),
setXX()/isXX() bean convention, Renjin provides some special sauce to make
access from R more natural.

Given the java bean: 

```{.java}
class Customer {
  String name;
  int age;

  String getName() { return name; }
  void setName(String name) { this.name = name; }
  
  int getAge() { return age; }
  void setAge(int age) { this.age = age; }
}
```

You can construct a new instance of the Customer class and provide initial
values with named arguments to the constructor:

```{.r}
import(com.acme.Customer)

bob <- Customer$new(name='Bob', age=36)
carol <- Customer$new(name='Carole', age=41)
```

Java bean properties must be accessed as variables rather than through method
calls:

```{.r}
bob$name <- "Bob II"
cat(c("Name: ", bob$name, "; Age: ", bob$age))
```

Java developer's guide to R objects
===================================




