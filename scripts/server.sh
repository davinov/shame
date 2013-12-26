#!/bin/bash

rm -rf _public
node_modules/.bin/brunch build -P
node_modules/.bin/forever start -c coffee _server.coffee --env=production
