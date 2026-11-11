cask 'openvox9-openbolt' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "9.0.0"
      sha256  "67feed5f2a535907dfc0fa8166b37a7a7bd9ce81d81f6de9b4862b21c659c04a"
    end
    on_intel do
      version "9.0.0"
      sha256  "e6e1e2db4ed1ebb52c37efa11d011234f1cb2a85b018c56d5eecc2005ace335d"
    end
  end

  depends_on macos: :ventura

  url "https://downloads.voxpupuli.org/mac/openvox9/openbolt-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openbolt-#{version}-1-installer.pkg"

  name 'OpenVox Openbolt'
  homepage "https://voxpupuli.org/openvox/"

  conflicts_with cask: "puppet-bolt"

  uninstall pkgutil: 'org.voxpupuli.openbolt'
end
