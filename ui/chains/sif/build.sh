#!/bin/bash

killall akhiranoded

rm $(which akhiranoded) 2> /dev/null || echo akhiranoded not install yet ...

rm -rf ~/.akhiranoded

cd ../../../ && make install 