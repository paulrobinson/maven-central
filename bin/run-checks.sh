#!/bin/bash

CHECK_ROOT=target/repository/org/jboss/jbossts/

if [ "$1" != "" ]; then
	CHECK_ROOT=$1
fi

echo "Checking: $CHECK_ROOT"

echo -e "\n\n==Looking for artefacts not in repo1.maven.org =="
cat output.txt  | grep Downloaded | grep -v "Downloaded: http://repo1.maven.org"
echo -e "\n\n== check-snapshot-deps.sh =="
bin/check-snapshot-deps.sh $CHECK_ROOT
echo -e "\n\n== validate-path.sh =="
bin/validate-path.sh $CHECK_ROOT
echo -e "\n\n== verify_gav_matches_path.rb =="
ruby bin/verify_gav_matches_path.rb $CHECK_ROOT
echo -e "\n\n== verify_no_release_repository.rb =="
ruby bin/verify_no_release_repository.rb $CHECK_ROOT
