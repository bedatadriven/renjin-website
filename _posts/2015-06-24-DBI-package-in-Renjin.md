---
layout: post
author: 
    name: Hannes Mühleisen
lang: en
tags: r-bloggers
title: "Using the DBI package in Renjin to connect to a variety of databases"
excerpt: R's DBI package provides unified access to a variety of databases.
    This package is now ported to Renjin and uses JDBC drivers in the background to
    achieve a nearly identical user experience as packages such as RSQLite,
    RPostgreSQL, RMySQL, MonetDB.R and ROracle.
---
  

For some months now, we have been working together with
[CWI Database Architectures group](https://www.cwi.nl/research-groups/database-architectures)
to bring some database sauce to Renjin. The first step in this line of work was
to create a set of
[R DBI](http://cran.r-project.org/web/packages/DBI/index.html) drivers for Renjin,
so that people can run R scripts that talk to a SQL database.

Today we are happy to announce initial support for the following databases:

* [SQLite](https://sqlite.org), a small embedded system
* [PostgreSQL](http://www.postgresql.org), a mature, row-oriented database for transactional workloads
* [MySQL](http://www.mysql.com), also a row-oriented database
* [MonetDB](https://www.monetdb.org/Home), a column-oriented database for analytical workloads
* [Oracle database](https://www.oracle.com/database/index.html), a row-oriented database produced and marketed by Oracle Corporation

We have worked hard to make our version of DBI source-compatible to the one in
GNU R, so that your scripts that use DBI are likely to continue working with
only minor changes.

Here is an example on how to use the DBI drivers, adapted from the
[RSQLite R](http://cran.r-project.org/web/packages/RSQLite/index.html) package:

```{.r}
library(RSQLite)
con <- dbConnect(SQLite(), ":memory:")

dbListTables(con)
dbWriteTable(con, "mtcars", mtcars)
dbListTables(con)

dbListFields(con, "mtcars")
dbReadTable(con, "mtcars")

# You can run a specific query
res <- dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
print(res)

# Or fetch the entire table
res <- dbReadTable(con, "mtcars")

# Disconnect from the database
dbDisconnect(con)
````

This example uses the embedded SQLite database, where no installation is
required. For information on how to install the other systems, please refer to
the respective documentation. Here are short snippets on how to establish
a connection to them:

```{.r}
library(RPostgreSQL)
con <- dbConnect(RPostgreSQL(), "jdbc:postgresql://localhost:5432/mydb", "myuser", "mypasswd")
````

```{.r}
library(RMySQL)
con <- dbConnect(RMySQL(), "jdbc:mysql://localhost:3306/mydb", "myuser", "mypasswd")
````

```{.r}
library(MonetDB.R)
con <- dbConnect(MonetDB.R(), "jdbc:monetdb://localhost:50000/mydb", "myuser", "mypasswd")
````

```{.r}
library(ROracle)
con <- dbConnect(ROracle(), url="jdbc:oracle:thin:@localhost", username="someuser", password="somepass")
```

We are curious to see what you will be doing with this new feature. If you run
into any issues, please let us know by opening an issue in the
[corresponding GitHub repository](https://github.com/hannesmuehleisen/renjin-dbi) or on the
[public Renjin mailing list](http://groups.google.com/group/renjin-dev).

Also, this package (which is Open Source like the rest of Renjin) shows how
complex Java APIs such as JDBC can be easily exposed to R scripts running in
Renjin. This allows you to combine the ease of statistical analysis using
R with the flexibility and code of the Java ecosystem.
