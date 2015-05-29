#!/bin/sh
#
# Generic script for updating and decrypting a license file
#
# Copyright (c) 2013-2015 Alex Williams, Unscramble. See the LICENSE file (MIT).
# https://unscramble.co.jp
#
# VERSION: 0.6.3

set -u
set -e

admin_dir="/opt/jidoteki/admin"
uploads_dir="${admin_dir}/home/sftp/uploads"

fail_and_exit() {
  echo "[`date +%s`][VIRTUAL APPLIANCE] Invalid or missing license file" 2>&1 | tee -a "${admin_dir}/log/update.log"
  exit 1
}

################

move_license_file() {
  cd "${uploads_dir}"

  if [ ! -f "license.asc" ]; then return 1; fi

  echo "[`date +%s`][VIRTUAL APPLIANCE] Updating license. Please wait.." 2>&1 | tee -a "${admin_dir}/log/update.log"
  mv -f license.asc ${admin_dir}/etc/
  chmod 640 "${admin_dir}/etc/license.asc" ; chown root:root "${admin_dir}/etc/license.asc"
  echo "[`date +%s`][VIRTUAL APPLIANCE] Updating license successful" 2>&1 | tee -a "${admin_dir}/log/update.log"
}

decrypt_license() {
  ${admin_dir}/bin/license.sh || return 1
}

################

move_license_file && \
decrypt_license   || fail_and_exit

exit 0
