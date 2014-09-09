#!/bin/bash
#
# Wrapper for executing admin commands on a virtual appliance
#
# Copyright (c) 2013-2014 Alex Williams, Unscramble. See the LICENSE file (MIT).

case "${SSH_ORIGINAL_COMMAND}" in
  "update")
    sudo /opt/jidoteki/admin/bin/update_vm.sh
    ;;
  *)
    exit 1
    ;;
esac
