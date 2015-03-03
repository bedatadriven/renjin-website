renjin-docs
===========

Documentation for [Renjin](https://github.com/bedatadriven/renjin), the R
interpreter for the JVM. Actually, this repo contains pretty much all of the
material for the Renjin website.

The documentation is written in the markdown format and uses
[Jekyll](http://www.jekyllrb.com) with a [Pandoc](http://johnmacfarlane.net/pandoc/README.html) 
plugin for building HTML pages.

Dependencies
------------

Make sure you have Ruby and Jekyll (version 1.0.2 or higher) installed. Then
install the pandoc-ruby gem with the following command:

    gem install pandoc-ruby

Usage
-----

In the `renjin.org` folder do `jekyll build` to compile the site, which will
end up in the `_site` folder. Then do `jekyll serve` (or `jekyll serve --watch`
to regenerate the site on-the-fly) to serve the site at `localhost:4000`.

Todo
----

The site is currently being redesigned and the following is a list of to-do's:

- [ ] update texts on About page
- [ ] add Disqus javascript to blog posts
- [ ] add Debian repository option to Downloads page
- [ ] add a backgound image to the header
- [ ] fix the source code being incorrectly displayed on a single line
- [ ] check that all links function correctly
- [ ] update this README
