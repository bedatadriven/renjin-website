---
layout: default
title: Developer guide
---

Introduction
============

This guide is for developers who want to call R from Java or visa versa. The
first scenario involves the evaluation of R expressions or scripts from a Java
application. The second scenario the use of Java classes inside an R program.
The first scenario is most common so that's the subject of the next section.

Using R within a Java project
-----------------------------

Before we start, it is good to realize that in these examples we are not
*calling R* as in GNU R. Technically, we have statements written in the
syntax of the R programming language and we are executing these statement using
the interpreter provided by Renjin. This is what makes Renjin different
from packages like [rJava](http://www.rforge.net/rJava/) and
[rcaller](https://code.google.com/p/rcaller/). 

The best way to call R from Java
is to use the 
[javax.scripting](http://docs.oracle.com/javase/6/docs/technotes/guides/scripting/programmer_guide/) 
interfaces. These interfaces are mature and guaranteed to be stable regardless
of how Renjin's internals evolve.

### A simple primer

We start with a very simple Java program to demonstrate how you can evaluate R from Java. The following is an example Java program stored in `SampleScript.java`:

```{.java}
import javax.script.*;

public class SampleScript {
  public static void main(String[] args) throws Exception {
    // create a script engine manager
    ScriptEngineManager factory = new ScriptEngineManager();
    // create a Renjin engine
    ScriptEngine engine = factory.getEngineByName("Renjin");
    // evaluate R code from String
    engine.eval("a <- 2; b <- 3; a*b");
  }
}
```

To to compile this example, Java needs to be able to find Renjin's scripting
engine. A JAR file containing the latest stable build of the scripting engine,
including all its dependencies, is available for download from
<http://nexus.bedatadriven.com/content/groups/public/org/renjin/renjin-script-engine/>.
Look for the latest release which is not a `SNAPSHOT` build. Currently this should be version {{ site.renjin-current }} and the JAR file will be called `renjin-script-engine-{{ site.renjin-current }}-jar-with-dependencies.jar`. 

Given the following directory layout:

    root/
    |
    |_ SampleScript.java
    |
    |_ libs/
       |
       |_ renjin-script-engine-{{ site.renjin-current }}-jar-with-dependencies.jar
    
you can compile and run your sample application using the following commands (assuming you have Java installed of course!) inside the `root` directory:

    javac -classpath .:libs/renjin-script-engine-{{ site.renjin-current }}-jar-with-dependencies.jar SampleScript.java
    java -classpath .:libs/renjin-script-engine-{{ site.renjin-current }}-jar-with-dependencies.jar SampleScript

and then you see... nothing. This is because Renjin evaluated the statement,
but we didn't do anything with the result. If we add R's `print` method to the
expression (i.e. `engine.eval("a <- 2; b <- 3; print(a*b)")`), then Renjin will
print the result to
[stdout](http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29).
This, however, is not very interesting as we want to be able to catch the
output in Java and store it in a variable for further use.

### Storing results from R in Java variables

The `engine.eval()` function returns an object of type `SEXP` which can be
casted to a `DoubleVector`. These are Renjin's representations of R language
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
    // evaluate R code from String, cast SEXP to a DoubleVector and store in the 'res' variable
    DoubleVector res = (DoubleVector)engine.eval("a <- 2; b <- 3; a*b");
    System.out.println("The result of a*b is: " + res);      
  }
}
```

Note that we need to import Renjin's object types and that we need to cast the
output of `engine.eval()` to the desired type.

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

Creating and distributing Renjin packages
=========================================

**TODO:** a whole chapter on how to create packages for Renjin. Assume that
Maven is a requirement and suggest a single solution (in other words: enforce
a convention) for the directory layout.
