cask 'openvox8-agent' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "8.29.0"
      sha256  "a7bbaa988feaba7d64c0e88a88c54d620aed79e9e3391e6f319f518e95ded7a5"
    end
    on_intel do
      version "8.29.0"
      sha256  "1ab816271d79efad6ffa0d2ea338d12721fb7f371af881e44d89857421823546"
    end
  end

  depends_on macos: :ventura

  url "https://downloads.voxpupuli.org/mac/openvox8/openvox-agent-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openvox-agent-#{version}-1-installer.pkg"

  name 'OpenVox Agent'
  homepage "https://voxpupuli.org/openvox/"

  conflicts_with cask: [
    "openvox-agent-8",
    "puppet-agent-8",
    "puppet-agent-7",
    "puppet-agent-6",
    "puppet-agent-5",
    "puppet-agent",
  ]

  uninstall launchctl: [
                         'puppet',
                         'pxp-agent',
                       ],
            pkgutil:   'org.voxpupuli.openvox-agent'

  zap trash: [
               '~/.puppetlabs',
               '/etc/puppetlabs',
             ]
end
