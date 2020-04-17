#!/bin/bash -e

# Start a cron job to back up the .persistent_history file
# to a safe place
# Ref: https://code.tutsplus.com/tutorials/scheduling-tasks-with-cron-jobs--net-8800

SAFE_PLACE=/work/
CRONJOB="15 * * * * cp ~/.persistent_history /work > /dev/null 2>&1"


if ! [ -x "$(command -v crontab)" ]; then
  echo 'Error: crontab is not installed.' >&2
  exit 1
fi

echo "MAILTO=\"ZHu4@slb.com\"" > tmp.txt
echo "$CRONJOB" >> tmp.txt
crontab tmp.txt
rm -rf tmp.txt

