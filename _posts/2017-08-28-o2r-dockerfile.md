---
layout: post
author: 
    name: Alexander Bertram
lang: en
title: "Renjin Docker image available on Docker Hub via o2r"
excerpt: The o2r project has made an Dockerfile for Renjin available on DockerHub
---

The [Opening Reproducible Research (o2r)](http://www.o2r.info) project has created a Dockerfile
for interactive analysis with Renjin's commmand line REPL:

```
$ docker run -it nuest/renjin /bin/bash
# renjin

> library("dplyr")
> mtcars$amfactor <- factor(mtcars$am, labels = c("automatic", "manual"))
> summary(lm(mpg ~ factor(amfactor), data = mtcars))$coef
> quit()

# ls /root/.m2/repository/org/renjin/cran/
# exit
```

View the project on [GitHub](https://github.com/nuest/renjin-docker) or on 
[DockerHub](https://hub.docker.com/r/nuest/renjin/)



