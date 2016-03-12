#!/bin/bash

#
# convert a directory tree into a json structure
#

../../bin/tree.rb ../.. --format js_treemap --force -o data.js
