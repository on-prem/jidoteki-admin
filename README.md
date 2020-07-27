# On-Prem virtual appliance & live image administration

[![GitHub release](https://img.shields.io/github/release/on-prem/jidoteki-admin.svg)](https://on-premises.com) [![Dependency](https://img.shields.io/badge/[deps]&#32;picolisp--semver-v0.11.0-ff69b4.svg)](https://github.com/aw/picolisp-semver) [![Dependency](https://img.shields.io/badge/[deps]&#32;picolisp--json-v4.1.0-ff69b4.svg)](https://github.com/aw/picolisp-json) [![Dependency](https://img.shields.io/badge/[deps]&#32;picolisp--unit-v3.0.0-ff69b4.svg)](https://github.com/aw/picolisp-unit.git) ![Build status](https://github.com/on-prem/jidoteki-admin/workflows/CI/badge.svg?branch=master)

[On-Prem](https://on-premises.com) installs the `On-Prem Admin` package in `/opt/jidoteki`.

This repository contains bash scripts, ansible roles, and other files needed to perform remote virtual appliance or live image administration, updates, etc.

# Requirements

* [PicoLisp](http://picolisp.com) 32-bit or 64-bit `v17.12+`
* Tested up to PicoLisp `v20.6.29`, [see test runs](https://github.com/on-prem/jidoteki-admin/commit/623b32b90aad3d96f97adcab20c5025978138bee/checks)
* Ansible `1.8.4` to `2.7.x`
* curl
* git
* sha1sum (from core-utils)
* dos2unix (from busybox)
* [symlinktool](https://github.com/on-prem/tinycore-symlinktool) for running backups
* [openssl](https://openssl.org/) v1.0.2+, for validating TLS certs
* [stunnel](https://www.stunnel.org) for validating TLS certs

# Usage

```
# replace <destdir> with the directory prefix to install the files
ansible-playbook jidoteki.yml -c local -i images.inventory -e prefix=<destdir> --tags=admin
```

### tags

There exist two `tags` for running the ansible roles:

  - **admin**: executes every task in the role, installing all On-Prem Admin scripts
  - **lib**: only executes tasks related to the lib dependencies, without the On-Prem Admin scripts

### admin role

The `admin` role configures directories and files in `/opt/jidoteki/tinyadmin`:

  * Create admin directory structure
  * Create admin directories writeable by root/admin
  * Create admin sftp uploads directory
  * Add SSH admin management scripts
  * Add SSH admin wrapper script
  * Add SSH admin lib dependencies

# Tests

To run the tests, type `make check`

# Changelog

See the [Changelog](CHANGELOG.md).

# License

This project is MIT licensed, see the [LICENSE](LICENSE) file for more info.
