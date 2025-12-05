cask 'openvox-agent-8' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "8.24.0"
      sha256  "1ff2ec9380d9f8377ce8585509d8a706070a5de577a501db0176b63e4b678d04"
    end
    on_intel do
      version "8.24.0"
      sha256  "ffe73329f2e3dca4a0036e564bc7e462c07e01b5a18ade8fa3cf75d2cd86eb64"
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
            pkgutil:   'org.voxpupuli.openvox-agent'

  zap trash: [
               '~/.puppetlabs',
               '/etc/puppetlabs',
             ]
end
