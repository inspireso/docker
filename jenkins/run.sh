#! /bin/bash
set -e
exec gosu jenkins /bin/tini -- /usr/local/bin/jenkins.sh