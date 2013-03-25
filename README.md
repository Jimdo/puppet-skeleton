Skeleton Puppet Module
======================

This is a testable Puppet module designed for you or your organization to fork
and modify appropriately. The module comes with everything you need to develop
infrastructure code with Puppet and feel confident about it. See chapter
**Testing** to learn more.

(While you're encouraged to customize everything in this module to fit your
needs, I recommend to keep the Testing chapter as an important part of this
README.)

Testing
=======

The module comes with some testing facilities allowing you to iterate quickly
on module changes. After installing the required Ruby gems with Bundler, most
of the testing can be done through convenient Rake tasks.

## Bundler

All tools you need for module development are installed as Ruby gems using
[Bundler](http://gembundler.com). This gives you complete control over your
software stack and makes sure that, for example, you're using the same version
of Puppet for testing as in production.

First, make sure you have Bundler (which is itself a gem):

    $ gem install bundler

Then let Bundler install the required gems (as defined in `Gemfile`):

    $ bundle install

Now you can use `bundle exec` to execute a command from the gems, for example:

    $ bundle exec rake test

(You should keep `Gemfile.lock` checked in.)

## Rake

The module provides a couple of helpful [Rake](http://rake.rubyforge.org) tasks
(specified in `Rakefile`):

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

The Rake task `lint` will use [puppet-lint](http://puppet-lint.com/) to run
lint checks on the module.

## puppet-rspec

The Rake task `spec` will run all RSpec examples in the `spec` directory. The
specs utilize [rspec-puppet](http://rspec-puppet.com/).

## Vagrant

With [Vagrant](http://vagrantup.com), you can spin up a virtual machine and run
your module inside it via Puppet Apply or Puppet Agent. The test setup requires
to install Vagrant 1.1.x from the [Vagrant downloads page](http://downloads.vagrantup.com/).

When everything is in place, this command will boot and provision the VM as
specified in the `Vagrantfile`:

    $ vagrant up

In case the VM is already up, you can run the provisioners again with:

    $ vagrant provision

License and Author
==================

Author:: Mathias Lafeldt (<mathias.lafeldt@gmail.com>)

Copyright:: 2013, Mathias Lafeldt

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
