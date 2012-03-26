#!/bin/bash

find $1 -type f | grep -v -e '.*maven-metadata.*' -e '\.sha1$' -e '\.md5$' -e '\.asc$' |
  grep -v -e '\([^/]*\)/\([^/]*\)/\1-\2[^/]*$'
