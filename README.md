# Jidoteki virtual appliance & live image administration

[![GitHub release](https://img.shields.io/github/release/unscramble/jidoteki-admin.svg)](https://github.com/unscramble/jidoteki-admin)

[Jidoteki](https://jidoteki.com) installs the `Jidoteki Admin` package in `/opt/jidoteki`.

This repository contains bash scripts, ansible roles, and other files needed to perform remote virtual appliance or live image administration, updates, etc.

## Version

[![GitHub tag](https://img.shields.io/github/tag/unscramble/jidoteki-admin.svg)](https://jidoteki.com)

## Requirements

* Ansible 1.5.x
* curl
* sha1sum (from core-utils)

## Ansible roles

There is one 1 role executed:

  - admin

### admin role

The `admin` configures directories and files in `/opt/jidoteki/admin` or `/opt/jidoteki/tinyadmin`.

Here is what the `admin` role does:

  * Create 'admin' directory structure
  * Create admin directories writeable by root/admin
  * Create admin sftp uploads directory
  * Add SSH admin management scripts
  * Add SSH admin wrapper script
  * Create '/opt/jidoteki/repos' directory structure

# Changelog

See the [Changelog](CHANGELOG.md).

# License

This project is MIT licensed, see the [LICENSE](LICENSE) file for more info.
