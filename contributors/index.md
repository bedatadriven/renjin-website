---
layout: default
title: Introduction for contributors
---

Documentation for contributors to Renjin
========================================

This documentation is for people who wish to contribute to the development of Renjin.

Repositories
------------

The main code repository is hosted at Github and can be found at
<https://github.com/bedatadriven/renjin>. Renjin was originally hosted on Google
Code and the repository at <https://code.google.com/p/renjin/> is regularly
synced with the main repository at Github.

To get started with the latest version of the code, clone the Github repository
using

    git clone https://github.com/bedatadriven/renjin.git

Building
--------

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

Filing a bug report
-------------------

The project currently uses the issue tracker on the Google Code project page:
<https://code.google.com/p/renjin/issues/list>.

Getting help
------------

The best way to get help is to send a question to the (public) mailing list via 
<mailto:renjin-dev@googlegroups.com>. The mail archive is accessible via Google
Groups at <http://groups.google.com/group/renjin-dev>.
