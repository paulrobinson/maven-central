#!/bin/bash

echo -e "== check-snapshot-deps.sh =="
bin/check-snapshot-deps.sh target/repository/org/jboss/jbossts/
echo -e "\n\n== validate-path.sh =="
bin/validate-path.sh target/repository/org/jboss/jbossts/
echo -e "\n\n== verify_gav_matches_path.rb =="
ruby bin/verify_gav_matches_path.rb target/repository/org/jboss/jbossts/
echo -e "\n\n== verify_no_release_repository.rb =="
ruby bin/verify_no_release_repository.rb target/repository/org/jboss/jbossts/
