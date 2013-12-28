#!/bin/bash

rm -rf _public
node_modules/.bin/brunch build -P
export NODE_ENV=production
node_modules/.bin/forever start -c coffee _server.coffee
