#!/bin/bash

pushd .
cd pages
for f in `find . -name "*.htmlm4"`
do
  changeddir="${f/./../html}"
  destination="${changeddir/m4/}"
  echo "${f} -> ${destination}"
  m4 "$f" > "$destination"
done
popd
