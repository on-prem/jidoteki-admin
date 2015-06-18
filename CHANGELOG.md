# Changelog

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
