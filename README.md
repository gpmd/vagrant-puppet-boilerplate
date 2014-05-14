# vagrant-puppet-boilerplate

A simple Vagrant boilerplate setup (configured using the [PuPHPet](https://puphpet.com/) GUI).

## Prerequisites

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)

## Usage

### Project directory structure

This config assumes your projects have a directory structure that looks something like this:

```
myproject/
myproject/site/
myproject/shared/
```

We track our projects one directory up from the site's webroot, which is usually `myproject/site/public_html/`. Therefore, you should clone your main project repo into the `myproject/site/` folder.

All assets you don't want tracked by git (such as environment config files, cache folders, media upload folders etc.) should be symlinked from their default locations in `myproject/site/public_html/` into `myproject/shared/`.

**Important: Don't run anything yet, such as `composer install`, `npm install`, `bower install` etc. on your project. You should only do this once your Vagrant box is up-and-running and you are logged in to the ssh shell.**

### Adding Vagrant

Essentially you have two options:

1. [Download this repo](https://github.com/gpmd/vagrant-puppet-boilerplate/archive/master.zip), and put all the contents (except `README.md`) into the `myproject/site/` directory.
2. Or, take just the [config.yaml](https://github.com/gpmd/vagrant-puppet-boilerplate/blob/master/puphpet/config.yaml) file from this repo and drop it onto the [puphpet.com](https://puphpet.com/) webpage, enabling you to modify all the settings at will and create your own manifest.

Whether you choose to download this repo or just use the `config.yaml` file with [puphpet.com](https://puphpet.com/), you will need to change all instances of **'myproject'** in `config.yaml` to the actual name of your project.

You should also make sure the paths in `config.yaml`, specifically the `synced_folder` and `vhosts` settings, reflect your own environment - again, we are assuming your webroot is `myproject/site/public_html/`, but if it's not you'll need to find the relevant section in `config.yaml` and change it.

Either way, it's worth familiarising yourself with [puphpet.com](https://puphpet.com/) to see what options are available to you.

### Adding your own dotfiles and shell scripts

* Put your own dotfiles in `myproject/site/puphpet/files/dot`.
* Put your own shell scripts in `myproject/site/puphpet/files/exec-always` or `myproject/site/puphpet/files/exec-once`.

**Node, Grunt, Bower and Compass**

If you choose to use this repo as-is, we have [already added a shell script](https://github.com/gpmd/vagrant-puppet-boilerplate/blob/master/puphpet/files/exec-once/frontend-tools.sh) to `myproject/site/puphpet/files/exec-once` that installs Node, Grunt-cli, Bower and Compass.

You can find out more about this on the [Server section of the PuPHPet website](https://puphpet.com/#server).

### Modifying your hosts file

On a Mac (and Linux I believe) the `hosts` files can be found in `/etc/hosts`. Simply add a new entry to the end of this file:

`192.168.56.101 myproject.dev`

**Note: The IP address should match the IP address found in `config.yaml`.**

### SSH keys

By default when you first `vagrant up` an `id_rsa` and `id_rsa.pub` file unique to your VM will be created in `/puphpet/files/dot/ssh`. However, you will probably want to replace these with your own `id_rsa` and `id_rsa.pub` files so you can connect to remote private Git repos as usual. Either do this after the first `vagrant up`, or just put them in the `/puphpet/files/dot/ssh` directory before the first provisioning and new ones won't be created.

You may also need to add a `config` file in your host computer's `~/.ssh` folder that contains the following:

```
Host *
ForwardAgent yes
```

This allows the host computer's SSH agent to forward requests from your VM.

## Using Vagrant

**Note: all `vagrant` commands should be run from your `myproject/site/` directory (and not from 'inside' the virtual machine)**

In order to set up your virtual machine for the first time (fair warning - this could take quite a while), or to restart it if you've halted it you need to run:

```bash
$ vagrant up
```

**Note: During the 'up' process you may be asked for a password in order to mount the NFS shared folders. You should enter your host machine's user password.**

Once the machine has started up and installed all its dependencies you can log in to the machine using:

```bash
$ vagrant ssh
```

**You can now do all your command line work on your project from within the Vagrant box ssh shell.**

You can put the machine to sleep by running:

```bash
$ vagrant halt
```

You can also just exit the machine (leaving it running in the background):

**Note: This command you would run from 'inside' the virtual machine.**

```bash
$ exit
```

If, after having already set up the machine, you add additional shell scripts to `myproject/site/puphpet/files/exec-always` you can provision these by running:

```bash
$ vagrant provision
```

You can get rid of the machine by running:

```bash
$ vagrant destroy
```

### 3.3 Git

The first time you 'up' the box you should set your Git user name and email. Run these two commands consecutively:

```bash
$ git config --global user.name "Your Name"
```

```bash
$ git config --global user.email you@example.com
```

## More info

What on earth are Vagrant, Puppet, PuPHPet? Read on...

* [Vagrant](http://www.vagrantup.com/)
* [Puppet](http://puppetlabs.com/puppet/puppet-open-source)
* [PuPHPet](https://puphpet.com/about)

## Author

*Matt Bailey:*

* [Github](https://github.com/matt-bailey)
* [Twitter](https://twitter.com/_mattbailey)
