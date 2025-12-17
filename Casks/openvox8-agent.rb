cask 'openvox8-agent' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "8.24.2"
      sha256  "57ebbddfecd5174b87acd2d94a49341a94f402f5cf38cac5c0b3640b74058974"
    end
    on_intel do
      version "8.24.2"
      sha256  "4dfa4e251b2042b3a0ef936469ab20dd4153294ff21ca4113524832907551898"
    end
  end

  depends_on macos: '>= :ventura'

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
