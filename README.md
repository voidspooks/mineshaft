# Mineshaft
Inspired by PyPA's Virtualenv, Mineshaft allows for the creation of isolated Ruby virtual environments. It aims to simplify the process of installing and using multiple versions of Ruby.

## Installation

Mineshaft is a Ruby gem, so you will need a working Ruby environment to use it.

```bash
gem install mineshaft
```

To build Ruby environments that are able to download gems from RubyGems, you will also need to install OpenSSL. You can install OpenSSL on MacOS via Homebrew.

```bash
brew install openssl
```

## Usage

### Creating a Virtual Environment

Create a new environment and install the latest stable version of Ruby.

```bash
ms new env
```

To specify a particular version of Ruby, use the `-r` flag.

```bash
ms new env -r 2.5.1
```

To use the new environment, you must activate it using the `activate.sh` script.

```bash
source env/bin/activate.sh
```

### Installing Globally

You can install a Ruby environment globally by running the following command. Please note that the name specified after `new` must be a valid Ruby version to install. This will replace your current system wide Ruby for the user running Mineshaft.

```bash
ms new 2.5.1 -g
```

To view all globally installed Rubies, use `-i`

```bash
ms -i
```

### Reloading Binaries

When you install a gem that has a binary associated with it, you will need to reload your global Ruby `bin` directory.

```bash
ms reload
```

### Switching Between Global Environments

To switch between environments, use the `use` keyword followed by a version of Ruby installed on your machine.

```bash
ms use 2.5.1
```

## Authors

Cameron Testerman   --  cameronbtesterman@gmail.com

Copyright 2017-2018, Cameron Testerman

Released under MIT license.  
