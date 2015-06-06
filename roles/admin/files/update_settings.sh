#!/bin/sh
#
# Generic script for updating the network and app settings
#
# Copyright (c) 2013-2015 Alex Williams, Unscramble. See the LICENSE file (MIT).
# https://unscramble.co.jp
#
# VERSION: 0.7.0

set -u
set -e

admin_dir="/opt/jidoteki/admin"
uploads_dir="${admin_dir}/home/sftp/uploads"
network_type=$1

fail_and_exit() {
  echo "[`date +%s`][VIRTUAL APPLIANCE] Invalid or missing network settings file" 2>&1 | tee -a "${admin_dir}/log/update.log"
  exit 1
}

################

move_settings_files() {
  cd "${uploads_dir}"

  if [ ! -f "network.json" ]; then return 1; fi

  mv -f network.json ${admin_dir}/etc/
  chmod 640 "${admin_dir}/etc/network.json" ; chown root:admin "${admin_dir}/etc/network.json"
}

save_network_settings() {
  echo "\n  Applying network settings.."
  echo "Starting network settings update at: `date`" >> ${admin_dir}/log/network_setup.log
  cd ${admin_dir}/ansible
    if [ "$network_type" = "dhcp" ]; then
      ansible-playbook ansible.yml --tags=network_setup,dhcp --skip-tags=static >> ${admin_dir}/log/network_setup.log 2>&1
    else
      ansible-playbook ansible.yml --tags=network_setup,static --skip-tags=dhcp >> ${admin_dir}/log/network_setup.log 2>&1
    fi
  echo "Ended network settings update at: `date`" >> ${admin_dir}/log/network_setup.log
}

################

# Run all the tasks
echo "[`date +%s`][VIRTUAL APPLIANCE] Updating settings. Please wait.." 2>&1 | tee -a "${admin_dir}/log/update.log"

move_settings_files && \
save_network_settings || fail_and_exit

echo "[`date +%s`][VIRTUAL APPLIANCE] Updating settings successful" 2>&1 | tee -a "${admin_dir}/log/update.log"
exit 0
