require 'digest'
require 'erb'
require 'net/http'
require 'tmpdir'

# URL where our MacOS builds are located
MACOS_BASE_URL = 'https://downloads.voxpupuli.org/mac'
# MacOS architectures we can support (symbolized)
SUPPORTED_ARCHITECTURES = %i[arm64 x86_64]
# Minimal supported MacOS version
MINIMAL_MACOS_VERSION_SUPPORTED = 'ventura'
# Map pkg name to collection name
PKG_TO_COLLECTIONS = {
  'openbolt' => 'openvox-tools'
}
# RE to decompose installer filename in a href
INSTALLER_HREF_RE = /href="([\w-]+)-(\d+\.\d+\.\d+(?:\.\d+)?)-\d\.macos\.all\.(#{SUPPORTED_ARCHITECTURES.join('|')})\.dmg"/
# Opposite to the above. Recompose installer filename from parts
def pinfo_to_filename(pinfo)
  "#{pinfo[:name]}-#{pinfo[:version]}-1.macos.all.#{pinfo[:arch]}.dmg"
end

def get_with_redirs(http, path, limit: 10)
  raise 'too many HTTP redirects' if limit == 0

  response = http.get(path)
  return response unless response == Net::HTTPRedirection

  get_with_redirs(http, response['location'], limit: limit - 1) if response == Net::HTTPRedirection
end

# Crawl the collection and gather supported OSes/packages/versions/etc.
# Returns array of hashes [{ pkg: ..., version: ..., arch: ... }, {...}]
def gather_downloads(collection)
  uri = URI("#{MACOS_BASE_URL}/#{collection}")

  puts "Crawling #{uri}/ ..."
  Net::HTTP.start(uri.hostname) do |http|
    resp = get_with_redirs(http, "#{uri.path}/") # Keep the trailing slash
    resp.body.scan(INSTALLER_HREF_RE).map do |x|
      { name: x[0], version: x[1], arch: x[2] }
    end
  end
end

# Get checksum of a package
def get_checksum(filename, collection)
  uri = URI("#{MACOS_BASE_URL}/#{collection}")

  puts "Fetching and calculating checksum for #{filename} ..."
  Net::HTTP.start(uri.hostname) do |http|
    resp = get_with_redirs(http, "#{uri.path}/#{filename}")
    return nil unless resp.is_a? Net::HTTPSuccess

    Digest::SHA256.hexdigest(resp.body)
  end
end

namespace :brew do
  desc 'Render cask file for a specific package: rake brew:cask[openbolt] or rake brew:cask[openvox-agent,8]'
  task :cask, [:pkg, :collection] do |task, args|
    pkg = args[:pkg]
    collection = PKG_TO_COLLECTIONS[pkg] || "openvox#{args[:collection]}"
    cask = pkg
    cask += '-' + args[:collection] if args[:collection]

    all_packages = gather_downloads(collection)
    my_packages = all_packages.filter { |x| x[:name] == pkg }
    max_version_by_arch = my_packages.group_by { |x| x[:arch] }.map do |arch, pkgs|
      [ arch, pkgs.max_by { |x| Gem::Version.new(x[:version]) } ]
    end.to_h

    package_data = max_version_by_arch.map do |arch, pinfo|
      filename = pinfo_to_filename(pinfo)
      [ arch, pinfo.merge(
        sha256: get_checksum(filename, collection),
        filename: filename,
      ) ]
    end.to_h

    source_stanza_erb = ERB.new(File.read(File.join(__dir__, 'templates', 'source_stanza.erb')), trim_mode: '-')
    source_stanza_content = source_stanza_erb.result_with_hash(
      base_url: "#{MACOS_BASE_URL}/#{collection}",
      pkg: pkg,
      minimal_macos_version_supported: MINIMAL_MACOS_VERSION_SUPPORTED,
      package_data: package_data,
    )

    cask_erb = ERB.new(File.read(File.join(__dir__, 'templates', "#{cask}.rb.erb")), trim_mode: '-')
    cask_content = cask_erb.result_with_hash(
      source_stanza: source_stanza_content
    )

    File.write(File.join(__dir__, 'Casks', "#{cask}.rb"), cask_content)
  end
end
