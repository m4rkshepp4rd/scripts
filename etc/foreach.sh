#!/usr/bin/env bash
for path in $(find Documents/_docs/scripts -name '*.sh'); do
    sed -e 's;echo "($(basename $0))";echo "($(basename $0))";' $path > $path.tmp && mv $path.tmp $path
done    
