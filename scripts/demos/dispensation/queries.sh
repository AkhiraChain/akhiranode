#!/usr/bin/env bash
rm -rf all.json pending.json completed.json
akiranoded q dispensation records-by-name ar1 All>> all.json
akiranoded q dispensation records-by-name ar1 Pending >> pending.json
akiranoded q dispensation records-by-name ar1 Completed>> completed.json