Testing
=======

This module comes with everything you need to develop infrastructure code with
Puppet and feel confident about it. The provided testing facilities allow you to
iterate quickly on cookbook changes.

After installing Vagrant and the required Ruby gems, most of the testing can be
done through convenient Rake tasks.

## Bundler

Apart from Vagrant, which is described later on, all tools you need for module
development and testing are installed as Ruby gems using [Bundler]. This gives
you a lot of control over the software stack ensuring that the testing
environment matches your production environment.

First, make sure you have Bundler (which is itself a gem):

    $ gem install bundler

Then let Bundler install the required gems (as defined in `Gemfile`):

    $ bundle install

Now you can use `bundle exec` to execute a command from the gemset, for example:

    $ bundle exec rake test

(You should keep `Gemfile.lock` checked in.)

## Rake

The module provides a couple of helpful [Rake] tasks (specified in `Rakefile`):

    $ rake -T
    rake build            # Build puppet module package
    rake clean            # Clean a built module package
    rake coverage         # Generate code coverage information
    rake help             # Display the list of available rake tasks
    rake lint             # Check puppet manifests with puppet-lint
    rake spec             # Run spec tests in a clean fixtures directory
    rake spec_clean       # Clean up the fixtures directory
    rake spec_prep        # Create the fixtures directory
    rake spec_standalone  # Run spec tests on an existing fixtures directory
    rake test             # Run all tests

As mentioned above, use `bundle exec` to start a Rake task:

    $ bundle exec rake test

All test-related tasks are described in more detail below.

## puppet-lint

The Rake task `lint` will use [puppet-lint] to run lint checks on the module.

## puppet-rspec

The Rake task `spec` will run all RSpec examples in the `spec` directory. The
specs utilize [rspec-puppet].

## Vagrant

With [Vagrant], you can spin up a virtual machine and run your module inside it
via Puppet Apply or Puppet Agent. The test setup requires to install **Vagrant
1.2.x** from the [Vagrant downloads page].

When everything is in place, this command will boot and provision the VM as
specified in the `Vagrantfile`:

    $ vagrant up

In case the VM is already up, you can run the provisioners again with:

    $ vagrant provision

Finally, if you no longer need the VM, you can destroy it:

    $ vagrant destroy --force

## Travis CI

The module includes a configuration for [Travis CI] that will run `rake test`
each time changes are pushed to GitHub. Simply enable Travis for your GitHub
repository to get free continuous integration.

Implementing CI with other systems should be as simple as running the commands
in `.travis.yml`.


[Bundler]: http://gembundler.com
[Rake]: http://rake.rubyforge.org
[Travis CI]: https://travis-ci.org
[Vagrant downloads page]: http://downloads.vagrantup.com/
[Vagrant]: http://vagrantup.com
[puppet-lint]: http://puppet-lint.com/
[rspec-puppet]: http://rspec-puppet.com/
