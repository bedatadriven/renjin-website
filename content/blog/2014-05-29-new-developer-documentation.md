title=New developer documentation and other news
date=2014-05-29
type=post
status=published
author=Maarten-Jan Kallen
lang=en
excerpt=After a long period of silence surrounding Renjin, we are now back with a completely revised guide for Java and R developers as well as some new functionality for creating packages for Renjin.
~~~~~~

We're are pleased to announce that we have completed a initial draft of
a completely revised guide for Java developers that want to use Renjin in their
applications and/or R developers that want to write extensions (*packages* in
R parlance) for Renjin. This new guide is now hosted by the fine folks at
[ReadTheDocs](http://www.readthedocs.org) and can be found at
<http://docs.renjin.org>. We welcome your feedback on this: the source code is
[hosted on GitHub](https://github.com/bedatadriven/renjin-docs) so you can
actively contribute to the documentation!

Last week also saw a new release candidate for Renjin: 0.7.0-RC7. Our goal for
the final 0.7.0 release is to improve Renjin's compatibility with GNU
R especially with R's *base* package. To help us get there, we have imported the
[thousands of micro-tests](https://github.com/allr/testr-py) that were created
by a team at Purdue University as part of their effort to create a test-driven
specification of the R programming language (see the
[abstract of their poster at the UseR!2013 conference](http://www.edii.uclm.es/~useR-2013/abstracts/files/164_testr_abstract_in_template.pdf)
in July last year). Another tool in our goal towards greater compatibility is
our build server for CRAN packages. This fully automated build service includes
functionality for regression testing which allows us to evaluate Renjin's
evolving ability to load and use the 5500+ packages currently available on
[CRAN](http://cran.r-project.org). We plan to update
<http://packages.renjin.org> soon to reflect the latest build state of each
package.

Very exciting is the addition of the necessary functionality to create packages
for Renjin. Head to the
[Writing Renjin extensions](http://docs.renjin.org/en/latest/writing-renjin-extensions.html)
chapter in the new developer guide to learn about how to build and install
packages that can be used by Renjin.

The current road map for Renjin is to have the JIT compiler finished for version
0.8.0 and full compatibility with the S4 system is planned for version 0.9.0. Stay tuned!
