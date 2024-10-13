#!/bin/bash

cd "$(dirname "$0")/../" || exit 1

/home/axel/sources/bash/bashdoc/bashdoc2md.sh \
    -l 2 \
    -r "https://github.com/axelhahn/bash_sqlite/blob/main/" \
    sqlite.class.sh \
    > docs/50_All_functions.md
