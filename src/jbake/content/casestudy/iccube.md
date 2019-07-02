title=Renjin and icCube: Enhancing data analysis in Business Intelligence software
type=casestudy
status=published
author=Alexander Bertram
lang=en
~~~~~~

# Introduction

In this Case Study, we explore how the Business Intelligence software
[icCube](https://www.iccube.com/) and its Dutch reseller and analytics expert, [Inside Vision](https://www.inside-vision.com/), leverage the rich capabilities of the R language for statistical analysis and enhance the end-results offered to their clients, by
integrating Renjin in their Java-based data analytics and visualization
solution.

We will see how Renjin acts as the motor in the analysis processes
where R needs to be used, enabling the efficient integration of R in
a production Java system. Also, the Case Study highlights how Renjin
enables the seamless cooperation between two different but powerful
fields of expertise; econometrics and business intelligence.
Being JVM-based, Renjin allows the smooth handover of the R code
from one specialization field to another, helping them avoid time-
and resource-consuming code conversion.

We spoke with **Mrs Nathalie Leroy, Head of Presales at icCube** and
**Mr. Arthur van de Berg Founder of Inside Vision and data analytics and
visualization expert** who explained what icCube offers, how clients
leverage its capabilities and what the role of Renjin is.

# icCube and Inside Vision

icCube is a Swiss Business Intelligence company providing the BI
software icCube to a variety of industries such as finance, healthcare,
real estate, telecommunications, energy, procurement and marketing,
among others. The software allows professionals to take informed
decisions based on advanced, multi-dimensional analyses from a variety
of data sources. icCube is a single Java process and uses the MDX
language for querying data sources such as relational databases,
spreadsheets, NoSQL databases among others, as well as more customized
sources such as IoT sources (e.g. sensor data.) Also, the tool allows
to create customizable dashboards out of the produced data models and
embedding these into third-party solutions or corporate environments,
a.k.a. Embedded Analytics.

![Diagram of icCube](/assets/img/iccube-flow.png)

Inside Vision is a company specialized in Business Intelligence and
Corporate Performance Management and is the exclusive reseller of
icCube in the Netherlands. The company assists other companies or
the public sector to implement the tool into their real-time production
systems as well as create data models and dashboards. In particular,
Inside Vision’s client example using Renjin detailed below, shows how
the client crafts their strategy and prioritizes their tasks with the
help of the analysis performed on icCube.

# The use of Renjin in icCube

Renjin, licensed under GNU Public License v2, is offered as a
separate open-sourced plugin for icCube, which is itself closed source.

Technically, icCube is hosting an instance of RenjinScriptEngine for
native access to Renjin. Scripts defined in MDX can then be executed
via that engine. Passing MDX entities as parameters is also supported
via engine variables and icCube data structure converters.

The plugin therefore allows R scripts to be executed inside the
software, empowering the data analysis process. By running R scripts,
icCube enriches its advanced analytical capabilities and the end-results
offered to the clients. 

Mrs Leroy explains: 

“Within an MDX query you can
insert an algorithm or function that is produced using R or Java to
make advanced mathematical calculations”.

Renjin allows R code to be executed safely in the same process as a
multithreaded JVM application, eliminating the overhead of copying
large amounts of data between icCube and the R runtime.

# Practical client example: Improving workflow efficiency for a Purchasing department

Mr. Arthur van de Berg presented an example of how icCube is being used
by [a client](https://www.linkedin.com/in/purfacts/) and explained how Renjin helped reach the desired end-result.
In the example, icCube was used to assist the client to prioritize a
list of activities according to certain conditions such as risks, costs,
processes and more. Following that, there was a need to optimize the
planning for these activities for the client. In order to do that, a
formula had to be developed. The solution came from the econometrics
field. An R script was developed to provide the asked values. The
R optimization script was seamlessly added and executed in icCube via
Renjin, completing the workflow.

![Screenshot of editing R code in icCube](/assets/img/iccube-categories.png)

Under the icCube “hood”, Renjin is used to integrate an R-algorithm
directly into an MDX query.

![Screenshot of editing R code in icCube](/assets/img/iccube-mdx-r.png)

The “R”-algorithm provides the optimal start - and end week for each
Cost Category, which icCube transforms into the following dashboard:

![Screenshot of editing R code in icCube](/assets/img/iccube-dashboard.png)


Talking about the implementation of the R script using Renjin, Mr.
Arthur van de Berg, the overall solution architect, notes:

> “This is a very easy integration. Once you have chosen/validated your
> R algorithm, simply embed it into the MDX query. Your models will
> then be directly applied to your latest data, enhancing the efficiency
> of your business decision-making process.”

Using R to solve more complex problems seemed to be the perfect solution
for the analytical environment of icCube. Mrs. Leroy explains why they
decided to use R and Renjin in their software:

> “The reason why we added the integration of Renjin in icCube is
> because these are two different kinds of tools. R is more for data
> discovery, data science, statistical analysis, algorithms,
> it's really powerful from a statistical and mathematical perspective.
> icCube on the other hand, is a tool made to put advanced analytics in
> production, in other words, applying calculations to live data. So,
> if we sum up, R really helps understanding your data, finding patterns,
> fitting models to your data, and icCube allows for putting these into
> production, in a real-time data analytical environment and with live
> interactive dashboards. They [R and icCube] really don't do the same
> thing, they complement each other and make the end-result much more
> powerful. This is why we added this integration, to give additional
> power and analysis flexibility to our customers.”

# Conclusion

All in all, thanks to the integration of Renjin, icCube and Inside
Vision combined the advantages of the Java world and the R world by
integrating the JVM-based Renjin in their Java-based solution. This led
to a very flexible and powerful end-result for their clients.

Also, people with any sort of specialization or background, be it
statistics, mathematics, econometrics or another field, can use their
preferred set of tools to develop R scripts, making the most out of the
rich and giving R community. Renjin comes in as the handover spoon
allowing this code to run in a Java environment, and giving to the
software development or the business intelligence team on the other
side the opportunity to offer new, added value to their customers.



