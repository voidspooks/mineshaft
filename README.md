# mineshaft
Inspired by PyPA's Virtualenv, Mineshaft allows for the creation of isolated Ruby virtual environments. It aims to simplify the process of installing and using multiple versions of Ruby.

## Installation

Mineshaft is a Ruby gem, so you will need a working Ruby environment to use it.

```bash
gem install mineshaft
```

To build Ruby environments that are able to download gems from RubyGems, you will also need to install OpenSSL. You can install OpenSSL on MacOS via Homebrew.

### MacOS
```bash
brew install openssl
```

### RHEL / CentOS / Amazon Linux
```bash
yum group install "Development Tools"
yum install openssl-devel
```

## Usage

### Creating a Virtual Environment

Create a new environment and install the latest stable version of Ruby.

```bash
ms new env
```

To specify a particular version of Ruby, add the version number after the env name

```bash
ms new env 3.4.0
```

To use the new environment, you must activate it using the `activate.sh` script.

```bash
source env/bin/activate.sh
```

### Installing Globally

You can install a Ruby environment globally by running the following command. Specify the version of Ruby after the `install` keyword. This will replace your current system wide Ruby for the user running Mineshaft.

```bash
ms install 3.4.0
```

To view all globally installed Rubies

```bash
ms env
```

### Reloading Binaries

When you install a gem that has a binary associated with it, you will need to reload your global Ruby `bin` directory.

```bash
ms reload
```

### Switching Between Global Environments

To switch between environments, use the `use` keyword followed by a version of Ruby installed on your machine.

```bash
ms use 3.4.0
```

## Development Resources

### Running Tests

There is rake test defined to run the test suite. `rspec` ~> 3.13.0 must be installed as a development dependency prior to running tests. 

```bash
rake test
```

## Authors

Cameron Testerman   --  cameronbtesterman@gmail.com

© 2017 Cameron Testerman

Released under MIT license.  
