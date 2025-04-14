cask 'openvox-agent-8' do
  arch arm: 'arm64', intel: 'x86_64'

  on_sequoia :or_newer do
    on_arm do
      version "8.13.0"
      sha256  "6db1cd63d293459a61e0763bc10d85041f70328c3e5fb54c6c113d13741def63"
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
