#!/bin/bash

node_modules/.bin/jade app/index.jade --pretty --out app/assets/

rm app/index.jade && rm -rf app/partials/
