# Sources for Renjin.org

This repository contains the sources required to build the static site at
http://www.renjin.org. The site is generated using [JBake](https://jbake.org)
and the templates use the
[FreeMarker](https://freemarker.apache.org/docs/dgui.html) templating engine.

The site has been tested with JBake version 2.6.3.

## Project structure

We use the [default project
structure](https://jbake.org/docs/2.6.3/#project_structure) recommended by
JBake:

* `content/` holds the content to be _baked_ into HTML output.
* `assets/` contains everything which needs to be copied as-is.
* `templates/` holds the FreeMarker templates.

## Building

Use `jbake -b` to build the site. The output will be copied into the `output/` folder.

Use `jbake -s` to start a local server at `http://localhost:8820` to test the website.

Use `./deploy.sh` to deploy the site to the Google Cloud bucket (note: this
requires `gsutil` and access permission to the bucket).

