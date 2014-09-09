# Jidoteki virtual appliance administration

[Jidoteki](https://jidoteki.com) installs the `Jidoteki Admin` package in `/opt/jidoteki`.

This repository contains bash scripts, ansible roles, and other files needed to perform remote virtual appliance administration, updates, etc.

## Ansible roles

There are currently 2 roles executed in the following order:

  - system
  - admin

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

### admin role

The `admin` configures directories and files in `/opt/jidoteki/admin`.

Here is what the `admin` role does:

  * Create '/opt/jidoteki/admin' directory structure
  * Copy the secure keyfile used to decrypt software packages
  * Create admin directories only writeable by root
  * Add 'admin/sftpadmin' user's public SSH key
  * Ensure 'admin/sftpadmin' user can't modify the authorized_keys file
  * Create admin sftp uploads directory
  * Add SSH admin management scripts
  * Add SSH admin wrapper script

# License

This project is MIT licensed, see the [LICENSE](LICENSE) file for more info.
