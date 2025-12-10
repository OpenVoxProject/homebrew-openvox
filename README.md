# OpenVox Homebrew Tap

A tap for [OpenVox](https://voxpupuli.org/openvox/) MacOS packages.

- [How do I install these packages?](#how-do-i-install-these-packages)
  - [OpenVox Agent](#openvox-agent)
- [Updating versions](#updating-versions)

## How do I install these packages?

```bash
brew install --cask openvoxproject/openvox/<package>
```

### OpenVox Agent

To install latest openvox-agent version [OpenVox Agent](https://github.com/openvoxproject/openvox-agent) with brew:

```bash
brew install openvoxproject/openvox/openvox-agent-8
```

## Updating versions

When new versions of packages are shipped, you can use a Rake task to update the Cask to the latest version and SHAs.

To update the versioned casks - for example `openvox-agent-8` - include the collection as a 2nd argument

```bash
bundle exec rake 'brew:cask[openvox-agent,8]'
```
