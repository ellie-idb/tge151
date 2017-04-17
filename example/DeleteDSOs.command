#!/bin/bash

cd "`dirname "$0"`"

find . -iname "*.dso" -and -not -ipath "*/tstpro/*" -print0 | xargs -0 rm -fv

