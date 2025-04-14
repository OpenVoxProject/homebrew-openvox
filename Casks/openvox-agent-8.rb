cask 'openvox-agent-8' do
  arch arm: 'arm64', intel: 'x86_64'

  on_sequoia :or_newer do
    on_arm do
      version "8.19.2"
      sha256  "0f93a2e80de0bf4b9903669b353ff5d8d288de1ddf80746386432064d5c2a79f"
    end
    on_intel do
      raise "Not supported"
    end
  end

  depends_on macos: '>= :sequoia'

  url "https://downloads.voxpupuli.org/mac/openvox8/#{MacOS.version.major}/#{arch}/openvox-agent-#{version}-1.osx#{MacOS.version.major}.dmg"
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
