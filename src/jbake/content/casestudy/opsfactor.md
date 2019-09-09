title=The OpsFactor Case: creating a solution for demand planning in Brazil using Renjin and Amazon Elastic Beanstalk
type=casestudy
status=published
description=Example of how to to combine R and Java for demand planning. Opsfactor uses Renjin and Amazon Elastic Beanstalk in their demand planning solution to integrate R and Java.
author=Alexander Bertram
lang=en
~~~~~~

# Introduction

In this Case Study we explore how Renjin is used by the company
[OpsFactor](http://opsfactor.com/) to develop a demand planning solution. Renjin, acting as a
bridge between the strongest components of the Java and the R world,
facilitates the cooperation between specialists and generalists and
accelerates the workflow of the company. We spoke with the founder of
OpsFactor, Erick Butler Poletto who explained what the company offers,
how they are using Renjin and R packages and how they leveraged the fact
that Renjin can be integrated with Amazon Elastic Beanstalk.

# The company

The OpsFactor company was created out of the emerging need for a retail demand planning solution for the LaTam market. The available planning solutions from major technology suppliers were focused on the industrial sector and complex to implement, so the need for a more specific retail-oriented solution that was quick to deploy led Mr. Poletto to create OpsFactor. Using the knowledge and experience accumulated from his previous working positions, Mr. Poletto created a user-oriented tool aimed to the process owners of the sales, operations and financial departments of medium-sized companies (USD 50M to 500M).

# The product

The tool, written in Java,  allows the team of OpsFactor to predict
demand and to plan accordingly,  to determine optimal pricing and to
optimize the supply chain plan eventually. The use of the R language
is a key factor for the company's work thanks to the vast variety of
packages available and its dynamic community. For their product, the
R language was the obvious solution for the statistical analysis
of the data collected.

More specifically, OpsFactor predicts the quantity of sales for each
location and for each product produced by the client companies.
To do that they are using two R packages designed for this type of
analyses: the 'forecast' and the 'Rpart' package. Then, based on these
predictions, they are able to advise companies on how to best supply
products and materials to stores so that there is no shortage.

# Renjin and the product

Renjin, being a JVM-based interpreter for the R language, was
integrated in this Java solution to enable the team to run the R
packages. By integrating Renjin into a tool written in Java, OpsFactor
manages to leverage the benefits of the solid infrastructure offered by
the Java world and the flexible and powerful potential of the R language.
With this integration, the team does the forecasting needed quickly and
calculates the effect of a promotion activity or campaign
(e.g. Black Friday) based on sales data.

Also, instead of losing time and resources translating the R packages
into the Java language, the team uses Renjin to accelerate their
workflow and use analyses written in R directly in production. This
maximizes collaboration between the two different fields of
expertise --  data science and application development.

# Renjin and Amazon Elastic Beanstalk

Thanks to its compatibility with Amazon Elastic Beanstalk, the team of
OpsFactor preferred using Renjin to JRI/rJava and proceeded in moving
their solution to a Platform as a Service. Amazon Elastic Beanstalk
allows the orchestration of various AWS services. It is an important
part of the company's infrastructure, since it offloads the burden of
maintaining servers. They decided not to use JRI/rJava, which would have
required additional staff time to install, configure and maintain.
Mr. Poletto notes “So basically you cannot use JRI on Beanstalk.
We had to create a custom server and install GNU R and it made server
maintenance more complicated. Using Beanstalk is a much easier way of
maintaining the services. And Renjin enabled that.”

As for the switch from JRI to Renjin, the decision was made based on the
fact that Renjin is easy to maintain compared to JRI and that the
switch is seamless.

Mr. Poletto explains, “As I worked with JRI before, the switch was
very seamless. It was really easy for me to get the idea. I didn't deal
with other resources but to do the basic stuff it was fairly easy.
[...] The advantage for us was the ease of maintenance compared to JRI.
So, as a self-contained JAR file we can just upload it and forget about
it. That's really good for us.”

All in all, the integration of Renjin in their demand planning Java tool,
allowed OpsFactor to use the best parts of two different language worlds;
the solid infrastructure for Java applications and the powerful
packages of the R language. The 'forecast' and 'Rpart' R packages are
used for predicting demand and for monitoring the effect of
promotional campaigns. Also, the use of Renjin in place of
translating R packages into the Java language, saves a lot of time and
facilitates the cooperation between the analyst and the application
developers. Finally, thanks to its compatibility with Amazon Elastic
Beanstalk, Renjin was the only available solution for this type of
integration and allowed the company to move their solution to a
platform as a Service.
