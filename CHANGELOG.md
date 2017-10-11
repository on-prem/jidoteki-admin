# Changelog

## 1.17.0 (2017-11-01)

  * Output more detailed info when creating a backup
  * Ensure license.asc has correct permissions
  * Fix minor issues in 'backup' script
  * Add 'replication' script for handling replication settings
  * Merge network settings commands for dhcp/static

## 1.16.0 (2017-10-02)

  * Ensure 'backup' script is included in builds
  * Remove support for Debian/CentOS

## 1.15.0 (2017-04-12)

  * Add 'backup' command to generate a backup archive of specific files
  * Ensure wrapper uses 'symlinktool.sh' instead of 'filetool.sh'
  * Output update script PID to '.task' file
  * Ensure update script TRAPs SIGINT and SIGTERM to exit cleanly
  * Don't prevent 'major' version updates and don't force bundles to increase the 'minor' version

## 1.14.0 (2017-01-09)

  * Add 'storage' command to store and update persistent storage options

## 1.13.0 (2016-10-27)

  * Add 'services' command to retrieve the various services status
  * Add error_code and error_message for vm updates. Issue unscramble/jidoteki-admin-api#23

## 1.12.1 (2016-10-14)

  * Memory optimization: cleanup update package earlier in the decryption process

## 1.12.0 (2016-09-24)

  * Reload nginx or stunnel when updating the SSL certificate rather than the admin API

## 1.11.0 (2016-04-24)

  * Source /etc/profile for consistent use of 'tar' command
  * Change directory permissions for 'admin' user
  * Update to Jidoteki Admin API v1.10.1

## 1.10.2 (2016-04-12)

  * Add missing scripts to ansible run

## 1.10.1 (2016-04-12)

  * Ensure 'certs' logs its status (running/failed/success) to status_certs.txt
  * Update to Jidoteki Admin API v1.9.0

## 1.10.0 (2016-04-06)

  * Add 'certs' command to update TLS certificates

## 1.9.1 (2016-04-04)

  * Only include 'logs.tar.gz' in the debug bundle if it exists

## 1.9.0 (2016-04-04)

  * Add 'debug' command to generate an encrypted support debug bundle

## 1.8.0 (2016-03-26)

  * Add code signing / verification of update packages

## 1.7.0 (2016-03-24)

  * Add mutex to prevent scripts from running simultaneously

## 1.6.0 (2016-03-22)

  * Update script decrypts non base64-encoded software packages
  * Update to Jidoteki Admin API v1.6.0

## 1.5.1 (2015-11-25)

  * Remove unbound variable check from update_vm script

## 1.5.0 (2015-11-24)

  * Source /etc/profile for consistent use of 'sort' command
  * Update to Jidoteki Admin API v1.5.0

## 1.4.2 (2015-10-10)

  * Space and efficiency improvements: pipe decryted package for extraction

## 1.4.1 (2015-10-10)

  * Fix regression in version sort

## 1.4.0 (2015-10-08)

  * Don't manage the 'version.txt' file in the update_vm script

## 1.3.3 (2015-10-07)

  * Change permissions on 'api.token' from 0640 to 0660
  * Output a different log message if no 'update.sh' script exists, exit cleanly

## 1.3.2 (2015-09-30)

  * Fix sorting issue for update packages >= 10. Closes #5

## 1.3.1 (2015-09-27)

  * Sudo reboot doesn't require nohup prefix
  * Ensure the 'admin' user is allowed to backup and reboot

## 1.3.0 (2015-09-26)

  * Ensure each script logs to its own log file
  * Add 'reboot' command

## 1.2.1 (2015-09-20)

  * Move 'network.conf' when updating network settings

## 1.2.0 (2015-09-20)

  * Update 'wrapper.sh' to perform a backup after a "destructive" command

## 1.1.2 (2015-09-18)

  * Allow 'admin' to write to certain dirs

## 1.1.1 (2015-09-16)

  * Add a 'prefix' variable for the path in every admin task
  * Remove reference

## 1.1.0 (2015-09-16)

  * Remove copying of the 'updates.key'
  * Remove creation of the 'version.txt'
  * Remove copying of the admin/sftpadmin SSH public key

## 1.0.0 (2015-09-09)

  * Update 'jidoteki-admin-api' to v1.2.0
  * Integrate live image management scripts
  * Make settings more generic by moving tasks to its own script
  * Add 'changelog' command to fetch the changelog.txt

## 0.9.2 (2015-08-21)

  * Update 'jidoteki-admin-api' to v1.1.6

## 0.9.1 (2015-07-24)

  * Add 'parson' as a dependency during build

## 0.9.0 (2015-07-06)

  * Add 'logs' command to fetch logs from the appliance
  * Add 'update_logs.sh' script to fetch compressed log files
  * Update API and dependency version

## 0.8.4 (2015-06-22)

  * Ensure temporary '.pil' directory exists

## 0.8.3 (2015-06-18)

  * Ensure uploads directory has 0770 permissions
  * Ensure the 'stunnel.log' file exists

## 0.8.2 (2015-06-18)

  * Ensure the dependency file ownership isn't preserved on install

## 0.8.1 (2015-06-18)

  * Update 'jidoteki-admin-api' to v1.0.1

## 0.8.0 (2015-06-17)

  * Update the 'app.json' if it was uploaded

## 0.7.1 (2015-06-12)

  * Fix filename of downloaded jidoteki-admin-api
  * Add requirements to README.md
  * Fix build for 64-bit deps
  * Ensure gcc dependency is installed

## 0.7.0 (2015-06-03)

  * Add 'api' role to install the Jidoteki Admin API
  * Add task to update the 'updates.key' file permissions

## 0.6.3 (2015-05-29)

  * Store the status of the update in a file

## 0.6.2 (2015-05-28)

  * Allow a user in the 'admin' group to read the updates.key

## 0.6.1 (2015-05-21)

  * Ensure token and settings update only works if the file was uploaded
  * Give 'admin' group read permissions on token and settings
  * Provide sudo access to all update_ commands
