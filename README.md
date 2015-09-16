# Jidoteki virtual appliance & live image administration

[Jidoteki](https://jidoteki.com) installs the `Jidoteki Admin` package in `/opt/jidoteki`.

This repository contains bash scripts, ansible roles, and other files needed to perform remote virtual appliance or live image administration, updates, etc.

## Version

[![GitHub tag](https://img.shields.io/github/tag/unscramble/jidoteki-admin.svg)](https://jidoteki.com)

## Requirements

* Ansible 1.5.x
* curl
* sha1sum (from core-utils)

## Ansible roles

There are currently 3 roles executed in the following order:

  - system
  - admin
  - api

### system role

The `system` role makes changes to the virtual appliance (outside of `/opt/jidoteki`), such as creating user accounts and adding files to `/etc`.

Here is what the `system` role does:

  * Disable 'requiretty' in sudoers file
  * Create 'admin' group
  * Create an 'admin' user with limited privileges (ssh commands)
  * Allow the 'admin' user to sudo
  * Create an 'sftpadmin' user with limited privileges (sftp uploads)
  * Setup SFTP chroot for 'sftpadmin' in sshd_config
  * Restart the SSH daemon
  * Create a local centos/debian/ubuntu package repository
  * Install 'reprepro' tool for installing local packages (debian/ubuntu only)
  * Install 'createrepo' tool for installing local packages (centos only)

### admin role

The `admin` configures directories and files in `/opt/jidoteki/admin` or `/opt/jidoteki/tinyadmin`.

Here is what the `admin` role does:

  * Create 'admin' directory structure
  * Create admin directories only writeable by root
  * Create admin sftp uploads directory
  * Add SSH admin management scripts
  * Add SSH admin wrapper script
  * Create '/opt/jidoteki/repos' directory structure
  * Run 'reprepro' to generate initial repo database (debian/ubuntu only)

### api role

The `api` role installs the [jidoteki-admin-api](https://github.com/unscramble/jidoteki-admin-api) in `/opt/jidoteki/api` (virtual appliances only)

Here is what the `api` role does:

  * Download and extract the API into `/opt/jidoteki/api`
  * Download and extract the dependencies into `/opt/jidoteki/api/.lib/`
  * Compile the dependency binaries
  * Run the `make` script to fetch the API dependencies

# Changelog

See the [Changelog](CHANGELOG.md).

# License

This project is MIT licensed, see the [LICENSE](LICENSE) file for more info.
