# OpenVox Homebrew Tap

A tap for [OpenVox](https://voxpupuli.org/openvox/) MacOS packages.

- [How do I install these packages?](#how-do-i-install-these-packages)
  - [OpenVox agent](#openvox-agent)
  - [OpenBolt](#openbolt)
- [Updating Casks](#updating-casks)

## How do I install these packages?

```bash
brew install --cask openvoxproject/openvox/<package>
```

### OpenVox Agent

```bash
# Install OpenVox agent v8
brew install openvoxproject/openvox/openvox8-agent

# Install OpenVox agent v9
brew install openvoxproject/openvox/openvox9-agent
```

### OpenBolt

```bash
# Install OpenBolt v8
brew install openvoxproject/openvox/openvox8-openbolt
```

## Updating Casks

When new version of a package is shipped, you should use the `brew:cask` Rake task to update the Cask related.

```bash
bundle exec rake 'brew:cask[agent,8]'
bundle exec rake 'brew:cask[openbolt,8]'
```

Here, second argument is "collection". It corresponds to the `openvox<major-version>` directory on the downloads.voxpupuli.org server.
