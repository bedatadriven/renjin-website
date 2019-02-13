#!/bin/sh

ROOT_DIR=$PWD
BUILD_DIR=output

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

# build the static website using JBake (https://jbake.org/):
jbake -b

# deploy the new site by copying to the server:
cp appengine.yaml $BUILD_DIR
gcloud --project=renjinci app deploy $BUILD_DIR

cd $ROOT_DIR

echo "---------"
echo "| Done! |"
echo "---------"
