cask 'openvox9-agent' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "9.0.0"
      sha256  "af633bfffef2672a7a4a7aac27643afa15091cb6b6d30c9b1a2119e557ac60e7"
    end
    on_intel do
      version "9.0.0"
      sha256  "69d0f3ff59e42e1335fab3fab8bd1d9e05e1f0bc19b48d45c27cf17e1a20a9f5"
    end
  end

  depends_on macos: :ventura

  url "https://downloads.voxpupuli.org/mac/openvox9/openvox-agent-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openvox-agent-#{version}-1-installer.pkg"

  name 'OpenVox Agent'
  homepage "https://voxpupuli.org/openvox/"

  conflicts_with cask: [
    "openvox8-agent",
    "openvox-agent-8",
    "puppet-agent-9",
    "puppet-agent-8",
    "puppet-agent-7",
    "puppet-agent-6",
    "puppet-agent-5",
    "puppet-agent",
  ]

  uninstall launchctl: [
                         'puppet',
                       ],
            pkgutil:   'org.voxpupuli.openvox-agent'

  zap trash: [
               '~/.puppetlabs',
               '/etc/puppetlabs',
             ]
end
