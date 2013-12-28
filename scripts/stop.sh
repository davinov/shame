#!/bin/bash

if node_modules/.bin/forever stopall; then
    echo "Server stopped"
fi;
