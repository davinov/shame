#!/bin/bash

rm -rf _public
node_modules/.bin/brunch build -P
