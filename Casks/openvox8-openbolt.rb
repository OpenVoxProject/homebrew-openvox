cask 'openvox8-openbolt' do
  arch arm: 'arm64', intel: 'x86_64'

  on_ventura :or_newer do
    on_arm do
      version "5.3.0"
      sha256  "c52543544f269f92ce73c08f15025f4c273ffae00cf1284624adb2a8458a0924"
    end
    on_intel do
      version "5.3.0"
      sha256  "c49531a681933e52fd285144525dc2157f999a7f7056487c1a2d965b35e7a993"
    end
  end

  depends_on macos: '>= :ventura'

  url "https://downloads.voxpupuli.org/mac/openvox8/openbolt-#{version}-1.macos.all.#{arch}.dmg"
  pkg "openbolt-#{version}-1-installer.pkg"

  name 'OpenVox Openbolt'
  homepage "https://voxpupuli.org/openvox/"

  conflicts_with cask: "puppet-bolt"

  uninstall pkgutil: 'org.voxpupuli.openbolt'
end
