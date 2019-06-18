# Sources for Renjin.org

This repository contains the sources required to build the static site at
http://www.renjin.org. The site is generated using [JBake](https://jbake.org)
and the templates use the
[FreeMarker](https://freemarker.apache.org/docs/dgui.html) templating engine.

The site has been tested with JBake version 2.6.4.

## Project structure

We use the [default project
structure](https://jbake.org/docs/2.6.3/#project_structure) recommended by
JBake:

* `src/content/` holds the content to be _baked_ into HTML output.
* `src/assets/` contains everything which needs to be copied as-is.
* `src/templates/` holds the FreeMarker templates.

## Building

Use `./gradlew bake` to build the site. The output will be copied into the `build/output/` folder.

Use `./gradlew preview` to start a local server at `http://localhost:8820` to test the website.

Use `./deploy.sh` to deploy the site to the Google Cloud bucket (note: this
requires `gsutil` and access permission to the bucket).

## Notes on markdown

To include source code, use a block like

    ```r
    f <- function(x) x^2
    ```

where the language indicator should not be wrapped in brackets like `{r}` or `{java}`.

To include tables, use the MultiMarkdown format like so

```markdown
| col1 | col2 |
| ---- | ---- |
|    1 |    a |
|    2 |    b |
```

