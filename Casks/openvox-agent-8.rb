cask 'openvox-agent-8' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "8.23.1"
      sha256  "d21b02ac4615ddc53ce66b75b2541b8bbc53239291082ac406d8c1a2e3d51b59"
    end
    on_intel do
      version "8.23.1"
      sha256  "4aebbb2a1bb79e04e10099a15b78861f8cfa0c807231b42fbdd0122e520b2475"
    end
  end

  depends_on macos: '>= :ventura'

  url "https://downloads.voxpupuli.org/mac/openvox8/openvox-agent-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openvox-agent-#{version}-1-installer.pkg"

  name 'OpenVox Agent'
  homepage "https://voxpupuli.org/openvox/"

  uninstall launchctl: [
                         'puppet',
                         'pxp-agent',
                       ],
            pkgutil:   'com.puppetlabs.puppet-agent'

  zap trash: [
               '~/.puppetlabs',
               '/etc/puppetlabs',
             ]
end
