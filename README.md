# Mineshaft
Inspired by PyPA's Virtualenv, Mineshaft allows for the creation of isolated Ruby virtual environments. It aims to simplify the process of installing and using multiple versions of Ruby.

## Installation

Mineshaft is a Ruby gem, so you will need a working Ruby environment to use it.

```bash
gem install mineshaft
```

## Usage

Create a new environment and install the latest stable version of Ruby.

```bash
mineshaft new <name_of_environment>
```

Create a new environment and specify the version of Ruby with `-r` and the OpenSSL install with `-o`.

```bash
mineshaft new .env -r 2.5.0 -o /usr/local/opt/openssl
```

To use the new environment, you must activate it using the `activate.sh` script.

```bash
source .env/bin/activate.sh
```

## Authors

Cameron Testerman   --  cameronbtesterman@gmail.com

Copyright 2017, Cameron Testerman

Released under MIT license.  
