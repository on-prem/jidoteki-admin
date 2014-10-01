#!/bin/sh
#
# Generic script for updating a virtual appliance
#
# Copyright (c) 2013-2014 Alex Williams, Unscramble. See the LICENSE file (MIT).
# http://unscramble.co.jp
#
# VERSION: 0.2.0

set -u
set -e

tar_cmd=`which tar`
openssl_cmd=`which openssl`
admin_dir="/opt/jidoteki/admin"
uploads_dir="${admin_dir}/home/sftp/uploads"

fail_and_exit() {
  echo "[`date +%s`][VIRTUAL APPLIANCE] Failed updating virtual appliance. Cleaning up.." 2>&1 | tee -a "${admin_dir}/log/update.log"
  exit 1
}

cleanup() {
  cd "${admin_dir}/tmp"

  rm -rf software_package* update
}

################

# Find the highest version package uploaded to the appliance
find_latest_package() {
  cd "${uploads_dir}"

  latest_package=`ls -r software_package-*.asc* | head -n 1`

  if [ ! "$latest_package" ]; then return 1; fi
}

# Decrypt the update package with the updates.key
decrypt_software_package() {
  cd "${admin_dir}/tmp"

  if [ ! "$latest_package" ]; then return 1; fi

  cp "${uploads_dir}/${latest_package}" "${admin_dir}/tmp/" && \
  $openssl_cmd aes-256-cbc -d -pass file:"${admin_dir}/etc/updates.key" -in "$latest_package" -a -out software_package.tar
}

# Extract the software_package
extract_software_package() {
  cd "${admin_dir}/tmp"

  mkdir -p update
  umask 027
  $tar_cmd --no-same-owner --no-same-permissions -xf software_package.tar -C update
}

# Compare the server and package versions
compare_versions() {
  cd "${admin_dir}/tmp/update"

  # Only compare if both files exist
  if [ -f "version.txt" ] && [ -f "${admin_dir}/etc/version.txt" ]; then
    package_version=`cat version.txt`
    server_version=`cat ${admin_dir}/etc/version.txt`
    latest=`echo "$server_version\n$package_version" | sort -V | tail -n 1`

    if [ "$latest" != "$package_version" ]; then
      echo "software update package ${package_version} is too old." 2>&1 | tee -a "${admin_dir}/log/update.log"
      return 1
    elif [ "$latest" = "$server_version" ]; then
      echo "software update package ${package_version} already up-to-date." 2>&1 | tee -a "${admin_dir}/log/update.log"
      return 1
    fi
  fi
}

# Update the virtual appliance and log the results
update_appliance() {
  cd "${admin_dir}/tmp/update"

  if [ -f "update.sh" ]; then
    echo "Starting update at: `date`" 2>&1 | tee -a "${admin_dir}/log/update.log"

    chmod +x update.sh
    ./update.sh || return 1
    cat version.txt > "${admin_dir}/etc/version.txt"
    chmod 644 "${admin_dir}/etc/version.txt" ; chown root:root "${admin_dir}/etc/version.txt"

    echo "Completed update at: `date`" 2>&1 | tee -a "${admin_dir}/log/update.log"
    rm -rf "${uploads_dir}/${latest_package}"
  fi
}

################

trap cleanup EXIT
trap 'exit 127' INT

# Run all the tasks
echo "[`date +%s`][VIRTUAL APPLIANCE] Updating virtual appliance. Please wait.." 2>&1 | tee -a "${admin_dir}/log/update.log"

find_latest_package       && \
decrypt_software_package  && \
extract_software_package  && \
compare_versions          && \
update_appliance          || fail_and_exit

echo "[`date +%s`][VIRTUAL APPLIANCE] Update successful" 2>&1 | tee -a "${admin_dir}/log/update.log"
exit 0
