# Jidoteki virtual appliance & live image administration

[![GitHub release](https://img.shields.io/github/release/unscramble/jidoteki-admin.svg)](https://jidoteki.com)

[Jidoteki](https://jidoteki.com) installs the `Jidoteki Admin` package in `/opt/jidoteki`.

This repository contains bash scripts, ansible roles, and other files needed to perform remote virtual appliance or live image administration, updates, etc.

## Requirements

* Ansible 1.5.x
* curl
* sha1sum (from core-utils)
* [symlinktool](https://github.com/aw/tinycore-symlinktool) for running backups
* [openssl](https://openssl.org/) v1.0.2+, for validating TLS certs
* [stunnel](https://www.stunnel.org) for validating TLS certs

## Ansible roles

There is 1 role executed:

  - admin

### admin role

The `admin` configures directories and files in `/opt/jidoteki/admin` or `/opt/jidoteki/tinyadmin`.

Here is what the `admin` role does:

  * Create admin directory structure
  * Create admin directories writeable by root/admin
  * Create admin sftp uploads directory
  * Add SSH admin management scripts
  * Add SSH admin wrapper script

# Changelog

See the [Changelog](CHANGELOG.md).

# License

This project is MIT licensed, see the [LICENSE](LICENSE) file for more info.
