---
layout: post
author: 
    name: Alex Bertram
lang: en
tags: r-bloggers
title: "The new packages.renjin.org"
excerpt: "Renjin's new packages.renjin.org offers continuous builds
    of CRAN packages for Renjin users, but is also part of a larger
    strategy to improve package management for R users running Renjin"
---

After more than a year of off-and-off work, we've finally 
gone live with the new [packages.renjin.org](http://packages.renjin.org). 
Take a look: you can browse and
[search](http://packages.renjin.org) for CRAN packages and
get clear information on whether Renjin can run the
package.

In designing the repository and Renjin's package loading mechanisms, we've
stayed pretty faithful to the way GNU R works, but we have made some subtle
changes to address a few pain points with the current system. I wanted to
outline a few of our goals and describe how we've tried to address them
with Renjin and `packages.renjin.org`.

## New package releases should never break other packages

Right now, GNU R's out of the box behavior is always to download the _latest_
version of all packages, and the latest version of all packages on which those
packages might depend.

Jeroen Ooms did a great 
[write up](http://journal.r-project.org/archive/2013-1/ooms.pdf)
of this problem, and cites an incident where a new version of `ggplot2`
was released, and suddenly all of the hundreds of packages were forced to
interact with a different version of `ggplot2` than that which they had been 
tested against. Confusion and chaos ensued, and `ggplot2 0.9.0` had to be 
rolled back.

There's no reason this _has_ to happen: other package ecosystems like Java's and
particuarly NPM are good models that demonstrate how complex networks of 
dependencies can be handled.

The first thing that has to happen is that package authors need to _version_
their dependencies, which is a way of saying not just that the package 
has been developed and tested against `ggplot2`, but `ggplot2 0.8.3`.

Because most package authors don't provide the versions of the packages on
which they depend, we've built a database of all CRAN
package versions dating back to 2001, and pinned each dependency version
based on publication dates. 

The second thing that's important is that multiple versions of a package
are able to co-exist side by side. You might want to use the latest and
greatest version of `ggplot2` when starting a new project, but if you're using 
an older package that depends on an earlier version of `ggplot2`, or you're 
rerunning your own analysis from six months ago, you'll want the older 
version of `ggplot2`.

The [Packrat](https://rstudio.github.io/packrat/) project has recently
made this a lot easier to do with GNU R, but Renjin supports this out of
the box. Each interpreter session can reference its own version of dependencies,
and Renjin maintains a local cache of dependencies, with different versions
of packages stored side by side.


## R packages should be useable on any platform without heartache

I've often wrestled with this in my own work, especially using R's fantastic
geostatistical packages, which depend on several native packages like 
gdal and geos, which in turn (often) need to be compiled from source,
and have numerous compile switches. I've found it very hard to return to 
an analysis making extensive use of these libraries six months later!

One decision we've made with Renjin is to focus on compiling the native 
C and Fortran code present in some CRAN packages to JVM bytecode rather than
building an integration based on calling out of the JVM and into native
binaries.

The downside is that it will be awhile before I get to use
my favorite geostatistical packages with Renjin, because our compiler can't
handle C code as complex as gdal yet. 

The upside is that a package once built for Renjin encapsulates all of its
dependencies, and can be effortlessly used on any platform: Linux, Mac OS X,
Windows, wherever there's a JVM available, and you'll never have to spend 
a sleepless night trying to get a Fortran compiler to build on some random 
version of Solaris on your client's backoffice system so you can for the love
of god please just get randomForest running!! 

## A unique package version should always refer to the same binary, bit for bit

Source code is not the only thing that determines the behavior of a package.
Whenever a package involves native code, the resulting binary depends on the
configuration used to build the package, the compiler used, and the versions
of standard and specialized libraries present on the system where the package
was compiled.

For this reason, when a CRAN package is built through the Renjin pipeline,
the resulting archive is given a version that includes both the version number
and the build number.

So if you reference `org.renjin.cran:survey:3.30-3-b227` in your application 
or analysis script, you can be sure that you six months from now, ten _years_ 
from now, you can run _exactly_ the same code on a completely different
operating system and get the same results.

## Package naming and loading should support any repository, not just CRAN

CRAN is no longer the only game in town when it comes to R packages. 
BioConductor of course supports an equally impressive library, and more 
and more R packages are being hosted exclusively on GitHub.

With this growth, identifying a package only by a single name like 
`survey` starts to become problematic. Is that the `survey` package from
CRAN or the one on that guy's GitHub account, or the ACME's internal fork?

In JVM land, packages are qualified with a 'groupId' that helps disambiguate
libraries with the same simple name. The convention is to use a domain name
that you control, to ensure that groupId's don't collide.

When we implemented package loading in Renjin, we tweaked the mechanism
a bit compared to GNU R to support fully qualified package names.

Following this convention, for example, we use the groupId `org.renjin.cran`
for CRAN packages because we don't control `org.r-project.cran`.

If you wanted to build and distribute your own package, you could use
use your personal domain as a groupId, or a subdomain that you control,
such as `com.github.akbertram`. 

When you call the library function, you should use the fully-qualified name,
for example, `library("com.github.akbertram.myPackage")` but if you leave
off the groupId, Renjin will assume that you mean a CRAN package and 
look for `org.renjin.cran.myPackage`.

## R Packages should seamlessly integrate with Java Projects

We want those developing in Java, Scala, Clojure, JRuby, or another
JVM-hosted language to be able to depend on R packages in the same way they
would on any other JVM library. Renjin compiles R packages into a Java Archive
(.jar) that can be included in any project.

For a Maven project, you can include the package as a library by adding 
a dependency to your `pom.xml` file:

```{.xml}
<dependencies>
    <dependency>
      <groupId>org.renjin.cran</groupId>
      <artifactId>survey</artifactId>
      <version>1.3-37</version>
    </dependency>
</dependencies>
```

Or pull the same package into a Gradle project:

```
dependencies {
   compile 'org.renjin.cran:survey:1.3-37-b203' 
}

repositories {
   mavenLocal()
   mavenCentral()
   maven { url 'http://nexus.bedatadriven.com/content/groups/public' }
}
```

The [scicom](https://github.com/rbotafogo/scicom) project goes even
further by providing fluent access to R functions and data structures in 
JRuby, via Renjin. 


## Enterprises should be able to manage R package dependencies with existing, best-in-class tools

Because Renjin organizes R packages using the same conventions as Maven, Ant,
and Ivy, enterprises who strictly manage dependencies with tools like 
[Sonatype Nexus](http://www.sonatype.org/nexus/), Artifactory, or Apache Archiva.

These artifact repositories allow organizations to set, enforce, and audit
policies concerning the use of dependencies within an organization.





