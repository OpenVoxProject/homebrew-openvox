cask 'openvox8-openbolt' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "5.6.0"
      sha256  "c08b5061712128d7e806aad5f81f6a190140a7af8ffde8aeff618fe8f2a37769"
    end
    on_intel do
      version "5.6.0"
      sha256  "b447f7c4b6489d5db4403e81892e4c7c46b571589347edbd397b8b593b291ee1"
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
