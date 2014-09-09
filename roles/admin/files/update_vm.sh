#!/bin/bash
#
# Generic script for updating a virtual appliance
#
# Copyright (c) 2013-2014 Alex Williams, Unscramble. See the LICENSE file (MIT).

TAR=`which tar`
OPENSSL=`which openssl`
SHRED=`which shred`
ADMIN_DIR="/opt/jidoteki/admin"
UPLOADS_DIR="${ADMIN_DIR}/home/sftp/uploads"

echo -e "\e[32m[ENTERPRISE APPLIANCE] Updating virtual appliance. Please wait..\e[39m"

fail_and_exit() {
  echo -e "\e[31m[ENTERPRISE APPLIANCE] Updating virtual appliance failed.\e[39m"
  cleanup
  exit 1
}

# Find the highest version package uploaded to the appliance
find_latest_package() {
  cd ${UPLOADS_DIR}

  LATEST_PACKAGE=`ls -r software_package-*.asc* | head -n 1`

  if [ "$LATEST_PACKAGE" == "" ]; then fail_and_exit; fi
}

# Decrypt the update package with the updates.key
decrypt_software_package() {
  cd ${ADMIN_DIR}/tmp

  if [ "$LATEST_PACKAGE" == "" ]; then fail_and_exit; fi

  mv ${UPLOADS_DIR}/${LATEST_PACKAGE} ${ADMIN_DIR}/tmp/
  $OPENSSL aes-256-cbc -d -pass file:${ADMIN_DIR}/etc/updates.key -in $LATEST_PACKAGE -a -out software_package.tar || fail_and_exit
}

# Extract the software_package
extract_software_package() {
  cd ${ADMIN_DIR}/tmp

  mkdir -p update
  umask 027
  $TAR --no-same-owner --no-same-permissions -xf software_package.tar -C update || fail_and_exit
}

# Compare the server and package versions
compare_versions() {
  cd ${ADMIN_DIR}/tmp/update

  # Only compare if both files exist
  if [ -f "version.txt" ] && [ -f "${ADMIN_DIR}/etc/version.txt" ]; then
    package_version=`cat version.txt`
    server_version=`cat ${ADMIN_DIR}/etc/version.txt`
    latest=`echo -e "$server_version\n$package_version" | sort -V | tail -n 1`

    if [ "$latest" != "$package_version" ]; then
      echo -e "\e[31m[ENTERPRISE APPLIANCE] Failed updating to ${package_version}, software package is too old.\e[39m"
      fail_and_exit
    elif [ "$latest" == "$server_version" ]; then
      echo -e "\e[31m[ENTERPRISE APPLIANCE] Failed updating to ${package_version}, already up-to-date.\e[39m"
      fail_and_exit
    fi
  fi
}

# Update the virtual appliance and log the results
update_appliance() {
  cd ${ADMIN_DIR}/tmp/update

  if [ -f "update.sh" ]; then
    echo "Starting update at: `date`" >> ${ADMIN_DIR}/log/update.log

    chmod +x update.sh
    ./update.sh >> ${ADMIN_DIR}/log/update.log 2>&1; test ${PIPESTATUS[0]} -eq 0 || fail_and_exit
    mv version.txt ${ADMIN_DIR}/etc/version.txt

    echo "Completed update at: `date`" >> ${ADMIN_DIR}/log/update.log
  fi
}

# Remove unnecessary files
cleanup() {
  cd ${ADMIN_DIR}/tmp/

  # Safe cleanup
  if [ -f "software_package.tar" ]; then
    $SHRED --force --remove --zero software_package.tar
  fi

  if [ ! "$LATEST_PACKAGE" == "" ]; then
    $SHRED --force --remove --zero $LATEST_PACKAGE
  fi

  # Cleanup
  rm -rf update
}

# Run all the tasks
find_latest_package
decrypt_software_package
extract_software_package
compare_versions
update_appliance
cleanup

echo -e "\e[34m[ENTERPRISE APPLIANCE] Update successful\e[39m"
exit 0
