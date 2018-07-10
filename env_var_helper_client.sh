#!/bin/bash

set -e

OLD_IFS="$IFS"
IFS=

TOTAL_ENTRIES=$(ruby env_var_helper_client.rb count_entries)
i="0"

while [ "$i" -lt $TOTAL_ENTRIES ]
do
  FULL_PATH=$(ruby env_var_helper_client.rb container_destination $i)
  DIR_PATH=$(dirname "${FULL_PATH}")
  mkdir -p $DIR_PATH

  FILE_CONTENTS=$(ruby env_var_helper_client.rb contents $i)
  echo -e $FILE_CONTENTS > $FULL_PATH
  i=$[$i+1]
done

IFS="$OLD_IFS"

"$@"
