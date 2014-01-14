#!/bin/bash

echo "*** SERVER TESTS ***"
node_modules/.bin/mocha test/server/server.spec.coffee

echo "*** CLIENT TESTS ***"
node_modules/.bin/karma start test/karma.conf.coffee
