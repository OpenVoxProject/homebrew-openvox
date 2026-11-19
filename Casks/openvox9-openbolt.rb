cask 'openvox9-openbolt' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "9.1.0"
      sha256  "0b6a376a42171aa3ce43a7c135c876f10ae23efcb0857d26d9d47c55acab3d51"
    end
    on_intel do
      version "9.1.0"
      sha256  "2991ffc77e0a7549d10dae151edf28fe1f1abfb83435f88b68f28abfe7470bf3"
    end
  end

  depends_on macos: :ventura

  url "https://downloads.voxpupuli.org/mac/openvox9/openbolt-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openbolt-#{version}-1-installer.pkg"

  name 'OpenVox Openbolt'
  homepage "https://voxpupuli.org/openvox/"

  conflicts_with cask: [
    "openvox8-openbolt",
    "puppet-bolt",
  ]

  uninstall pkgutil: 'org.voxpupuli.openbolt'
end
