#!/bin/sh
JEKYLL_ENV=production jekyll build && cd _site && gsutil cp -R -a public-read * gs://www.renjin.org
