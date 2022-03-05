#!/bin/bash

killall akiranoded

rm $(which akiranoded) 2> /dev/null || echo akiranoded not install yet ...

rm -rf ~/.akiranoded

cd ../../../ && make install 