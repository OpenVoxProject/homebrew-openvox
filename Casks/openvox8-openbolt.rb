cask 'openvox8-openbolt' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "5.5.0"
      sha256  "7baa8e1f41776d5eed490ff6a038c7f7dc33121806b12f41870a6db1f659f935"
    end
    on_intel do
      version "5.5.0"
      sha256  "4b937f0c2e89309a654e824b4a9681c7cf018ca8f0e734ca6b4a2c86e6cd127e"
    end
  end

  depends_on macos: :ventura

  url "https://downloads.voxpupuli.org/mac/openvox8/openbolt-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openbolt-#{version}-1-installer.pkg"

  name 'OpenVox Openbolt'
  homepage "https://voxpupuli.org/openvox/"

  conflicts_with cask: "puppet-bolt"

  uninstall pkgutil: 'org.voxpupuli.openbolt'
end
