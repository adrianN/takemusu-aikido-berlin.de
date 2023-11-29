#!/bin/bash

find html/gallery/*.html -delete
rm generated/*
pushd .
cd pages
for f in `find . -name "*.htmlm4"`
do
  changeddir="${f/./../html}"
  destination="${changeddir/m4/}"
  rm "$destination"
done
popd
