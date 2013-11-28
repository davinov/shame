#!/bin/bash

rm -rf _public
node_modules/.bin/brunch build -P
node_modules/.bin/forever restart -c coffee _server.coffee
