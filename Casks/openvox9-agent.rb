cask 'openvox9-agent' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "9.3.0"
      sha256  "a34ac2c21f6988144beb2b3df3a3e0a6b4a5a648402bef328e5a2c0bd9b21f28"
    end
    on_intel do
      version "9.3.0"
      sha256  "446dd1b4aa0faa142b32fa0c44f47dd2d39c6991fbd1527216f9ce9acfdd18db"
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
