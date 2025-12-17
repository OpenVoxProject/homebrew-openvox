# OpenVox Homebrew Tap

A tap for [OpenVox](https://voxpupuli.org/openvox/) MacOS packages.

- [How do I install these packages?](#how-do-i-install-these-packages)
  - [openvox8-agent](#openvox8-agent)
  - [openvox8-openbolt](#openvox8-openbolt)
- [Updating versions](#updating-versions)

## How do I install these packages?

```bash
brew install --cask openvoxproject/openvox/<package>
```

### openvox8-agent

```bash
brew install openvoxproject/openvox/openvox8-agent
```

### openvox8-openbolt

```bash
brew install openvoxproject/openvox/openvox8-openbolt
```

## Updating Casks

When new version of a package is shipped, you should use the `brew:cask` Rake task to update the Cask related.

```bash
bundle exec rake 'brew:cask[agent,8]'
bundle exec rake 'brew:cask[openbolt,8]'
```

Here, second argument (`8`) is "collection". It corresponds to the `openvox8` directory on the downloads.voxpupuli.org server.
