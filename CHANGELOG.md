# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2018-07-02
### Added
- Globally installed versions of Ruby: 
  - Correctly update the PATH variable by adding a line to .bash_profile
  - Installed in ~/.mineshaft
  - Symlinks are created from the global install to ~/.mineshaft/bin
- Added 2.6.0-preview1 and 2.6.0-preview2 install options
- Added CHANGELOG.md

### Changed
- Global installs are now denoted by a `-g` flag instead of using the `global` keyword.
- OpenSSL is now assumed to be installed in `/usr/local/opt/openssl`; the documentation is updated to recommend users to have OpenSSL installed prior to using Mineshaft
