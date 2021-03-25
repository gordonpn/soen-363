#!/bin/bash

set -Eeuo pipefail
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
sqlite_file="$script_dir/switrs.sqlite"

if [ ! -f "$sqlite_file" ]; then
  echo "$sqlite_file not found in current directory."
  exit 1
fi

if ! command -v sqlite3 &>/dev/null; then
  echo "sqlite3 must be installed."
  exit 1
fi

sqlite3 -header -csv switrs.sqlite "select collisions.* from collisions where collision_date like '2020%' or collision_date like '2019%';" >collisions.csv &
sqlite3 -header -csv switrs.sqlite "select parties.* from parties join collisions on collisions.case_id = parties.case_id where collision_date like '2020%' or collision_date like '2019%';" >parties.csv &
sqlite3 -header -csv switrs.sqlite "select victims.* from victims join collisions on collisions.case_id = victims.case_id where collision_date like '2020%' or collision_date like '2019%';" >victims.csv &
wait
echo "Done"
