#!/bin/sh
#
# Wrapper for executing admin commands on a virtual appliance
#
# Copyright (c) 2013-2015 Alex Williams, Unscramble. See the LICENSE file (MIT).
# https://unscramble.co.jp
#
# VERSION: 0.6.3

admin_dir="/opt/jidoteki/admin"

case "${SSH_ORIGINAL_COMMAND}" in
  "update")
    sudo ${admin_dir}/bin/update_vm.sh
    ;;
  "version")
    if [ -f "${admin_dir}/etc/version.txt" ]; then cat ${admin_dir}/etc/version.txt; fi
    ;;
  "license")
    sudo ${admin_dir}/bin/update_license.sh
    ;;
  "settings static")
    sudo ${admin_dir}/bin/update_settings.sh static
    ;;
  "settings dhcp")
    sudo ${admin_dir}/bin/update_settings.sh dhcp
    ;;
  "token")
    sudo ${admin_dir}/bin/update_token.sh
    ;;
  *)
    exit 1
    ;;
esac
