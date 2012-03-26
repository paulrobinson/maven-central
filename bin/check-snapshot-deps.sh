#!/bin/bash

echo "================================================================"
echo "[1] Gathering problematic POMs to poms-with-snapshots-raw.txt ..."
find $1 -name '*.pom' | xargs grep -e '-SNAPSHOT</' > poms-with-snapshots-raw.txt

echo "[2] Cleaning report to poms-with-snapshots-clean.txt ..."
cat poms-with-snapshots-raw.txt | sed 's/:.*//g' | sort | uniq > poms-with-snapshots-clean.txt

echo "[3] Generating temporary fixed POMs ..."
# cat poms-with-snapshots-clean.txt | xargs -i sh -c 'sed "s/-SNAPSHOT//g" {} > {}.tmp'

echo "[4] Replacing problematic POMs with fixed POMs ..."
# cat poms-with-snapshots-clean.txt | xargs -i mv {}.tmp {}

echo "    $(cat poms-with-snapshots-clean.txt | wc -l) POMs have been processed"
echo "================================================================"

