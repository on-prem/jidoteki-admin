#!/bin/sh
#
# Generic script for retrieving update logs
#
# Copyright (c) 2013-2015 Alex Williams, Unscramble. See the LICENSE file (MIT).
# https://unscramble.co.jp
#
# VERSION: 0.9.0

set -u
set -e

admin_dir="/opt/jidoteki/admin"
log_file="/tmp/logs.tar.gz"
log_dirs="/opt/jidoteki/admin/log /opt/jidoteki/api/stunnel.log ${1}"

fail_and_exit() {
  echo "[`date +%s`][VIRTUAL APPLIANCE] Invalid or missing log file" 2>&1 | tee -a "${admin_dir}/log/update.log"
  exit 1
}

################

compress_log_files() {
  echo "[`date +%s`][VIRTUAL APPLIANCE] Generating compressed logs.tar.gz. Please wait.." 2>&1
  tar --ignore-failed-read -zcf $log_file ${log_dirs}
  chmod 640 $log_file ; chown root:admin $log_file
  mv -f $log_file ${admin_dir}/home/sftp/uploads/
  echo "[`date +%s`][VIRTUAL APPLIANCE] Generated logs successful" 2>&1
}

################

compress_log_files || fail_and_exit

exit 0
