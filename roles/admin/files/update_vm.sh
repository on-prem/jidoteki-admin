#!/bin/sh
#
# Generic script for updating a virtual appliance
#
# Copyright (c) 2013-2014 Alex Williams, Unscramble. See the LICENSE file (MIT).
# http://unscramble.co.jp
#
# VERSION: 0.4.1

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
    version_regex="^(.*\-*v*)([0-9]+)\.([0-9]+)\.([0-9]+)$"
    package_version=`cat version.txt`
    server_version=`cat ${admin_dir}/etc/version.txt`

    # Note: this requires GNU sort from coreutils
    latest=`/bin/echo -e "$server_version\n$package_version" | sort -V | tail -n 1`

    package_major=`echo $package_version | sed -E "s/$version_regex/\2/"`
    package_minor=`echo $package_version | sed -E "s/$version_regex/\3/"`
    package_patch=`echo $package_version | sed -E "s/$version_regex/\4/"`

    server_major=`echo $server_version | sed -E "s/$version_regex/\2/"`
    server_minor=`echo $server_version | sed -E "s/$version_regex/\3/"`
    server_patch=`echo $server_version | sed -E "s/$version_regex/\4/"`

    next_minor=`expr $server_minor + 1`

    # Ensure the package isn't too old
    if [ "$latest" != "$package_version" ]; then
      echo "software update package v${package_version} is too old." 2>&1 | tee -a "${admin_dir}/log/update.log"
      return 1
    fi

    # Ensure the package isn't the exact same
    if [ "$package_version" = "$server_version" ]; then
      echo "software update package v${package_version} already up-to-date." 2>&1 | tee -a "${admin_dir}/log/update.log"
      return 1
    fi

    # Ensure the major version matches
    if [ "$package_major" != "$server_major" ]; then
      echo "software update package v${package_version} must be v${server_major}.x.x" 2>&1 | tee -a "${admin_dir}/log/update.log"
      return 1
    fi

    # If it's a bundle, we only care if the minor is greater or equal
    if [ -f "bundle.txt" ]; then
      if [ "$package_minor" -ge "$server_minor" ]; then
        return 0
      else
        echo "software update package v${package_version} must be v${server_major}.${server_minor}.x or greater" 2>&1 | tee -a "${admin_dir}/log/update.log"
        return 1
      fi
    else
      # Ensure the minor version is equal or +1
      if [ "$package_minor" = "$server_minor" ] || [ "$package_minor" = "$next_minor" ]; then
        return 0
      else
        echo "software update package v${package_version} must be v${server_major}.${server_minor}.x or v${server_major}.${next_minor}.x" 2>&1 | tee -a "${admin_dir}/log/update.log"
        return 1
      fi
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
