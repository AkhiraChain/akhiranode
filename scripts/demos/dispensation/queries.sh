#!/usr/bin/env bash
rm -rf all.json pending.json completed.json
akhiranoded q dispensation records-by-name ar1 All>> all.json
akhiranoded q dispensation records-by-name ar1 Pending >> pending.json
akhiranoded q dispensation records-by-name ar1 Completed>> completed.json