cask 'openvox8-agent' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "8.28.0"
      sha256  "c52c3696a090ec1cddfb4264e9a04f4a6e1e83b8c325d66bdd85103a940981cd"
    end
    on_intel do
      version "8.28.0"
      sha256  "2ad126b1ecdc2e62c9a8fd372d0026ad491101cc3e1bb624317c6ddbb08fd8f6"
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
