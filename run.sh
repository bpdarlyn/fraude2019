#!/usr/bin/env bash
platform=`uname`
if [[ "$platform" == 'Darwin' ]]; then
    ./bin/overmind-macos s -f Procfile
else
    ./bin/overmind-linux s -f Procfile
fi