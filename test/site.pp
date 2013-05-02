# This manifest is the entry point for `rake vagrant:provision`.
# Use it to set up integration tests for this Puppet module.

# Update Debian package index
include apt::update
exec { '/bin/true': notify => 'Exec[apt_update]' }

# Test the module
include skeleton
