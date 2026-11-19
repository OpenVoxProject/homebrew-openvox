cask 'openvox9-agent' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "9.5.0"
      sha256  "d4ce14bfb689579ada187dd925ef09a5f3f29942a39a1ddcedee13a82703aa13"
    end
    on_intel do
      version "9.5.0"
      sha256  "1c97b76147dd7b5e5cd60c4e668caa4bc4235553f13973ea7fd8fb913f35e99d"
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
