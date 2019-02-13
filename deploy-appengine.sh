#!/bin/sh

ROOT_DIR=$PWD
BUILD_DIR=output

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

# build the static website using JBake (https://jbake.org/):
jbake -b

# deploy to AppEngine
gcloud --project=renjinci app deploy

cd $ROOT_DIR

echo "---------"
echo "| Done! |"
echo "---------"
