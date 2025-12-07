cask 'openvox-agent-8' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "8.24.1"
      sha256  "88c88f45e39091820663af97e42ed3f1be9687bf3285c1cd5027c2cd38c33c40"
    end
    on_intel do
      version "8.24.1"
      sha256  "76a648777168bd05a117d9fbe66c5eebf62a76eda9fd4796c6c266d3df01e565"
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
