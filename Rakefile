require 'digest'
require 'erb'
require 'net/http'
require 'tmpdir'

# URL where our MacOS builds are located
MACOS_BASE_URL = 'https://downloads.voxpupuli.org/mac'
# MacOS architectures we can support (symbolized)
SUPPORTED_ARCHITECTURES = %i[arm64 x86_64]
# MacOS versions we can support
SUPPORTED_OS_VERSIONS = %w[13 14 15]
# Map MacOS version number to codename
VERSION_TO_CODENAME = {
  '13' => 'ventura',
  '14' => 'sonoma',
  '15' => 'sequoia'
}
# Map pkg name to collection name
PKG_TO_COLLECTIONS = {
  'openvox-bolt' => 'openvox-tools'
}

def get_with_redirs(http, path, limit: 10)
  raise 'too many HTTP redirects' if limit == 0

  response = http.get(path)
  return response unless response == Net::HTTPRedirection

  get_with_redirs(http, response['location'], limit: limit - 1) if response == Net::HTTPRedirection
end

# Crawl the collection and gather supported OSes/packages/versions/etc.
# Returns hash {os_ver => {arch => { pkg: ..., version: ... }}}
def gather_downloads(collection)
  uri = URI("#{MACOS_BASE_URL}/#{collection}")

  puts "Crawling #{uri}/ ..."
  Net::HTTP.start(uri.hostname) do |http|
    os_versions = {}
    SUPPORTED_OS_VERSIONS.each do |os_ver|
      packages = {}
      SUPPORTED_ARCHITECTURES.each do |arch|
        path = "#{os_ver}/#{arch}"
        puts " -> #{path} ..."
        resp = get_with_redirs(http, "#{uri.path}/#{path}/") # Keep the trailing slash
        pinfo = resp.body.scan(/href="(([\w-]+)-(\d+\.\d+\.\d+(?:\.\d+)?)-\d\.osx#{os_ver}\.dmg)"/).map do |x|
          { pkg: x[1], version: x[2] }
        end

        packages[arch] = pinfo if pinfo.length > 0
      end
      os_versions[os_ver] = packages if packages.length > 0
    end
    os_versions
  end
end

# Collect checksums
# Returns hash {os_ver => {arch => { sha256: ..., version: ... }}}
def gather_checksums(os_packages, collection, pkg)
  uri = URI("#{MACOS_BASE_URL}/#{collection}")

  puts 'Fetching and calculating checksums ...'
  Net::HTTP.start(uri.hostname) do |http|
    os_packages.map do |os_ver, pba|
      by_arch = {}
      pba.each do |arch, pinfo|
        # Find highest version number for the arch (if any)
        max = pinfo.filter { |x| x[:pkg] == pkg }.max_by { |x| Gem::Version.new(x[:version]) }
        next unless max.length > 0

        path = "#{os_ver}/#{arch}/#{max[:pkg]}-#{max[:version]}-1.osx#{os_ver}.dmg"
        puts " -> #{path} ..."
        resp = get_with_redirs(http, "#{uri.path}/#{path}")
        next unless resp.is_a? Net::HTTPSuccess

        by_arch[arch] = {
          sha256: Digest::SHA256.hexdigest(resp.body),
          version: max[:version]
        }
      end

      [os_ver, {
        os_name: VERSION_TO_CODENAME[os_ver],
        pkg_info: by_arch
      }]
    end.to_h
  end
end

namespace :brew do
  desc 'Render cask file for a specific package: rake brew:cask[openvox-bolt] or rake brew:cask[openvox-agent,8]'
  task :cask, [:pkg, :collection] do |task, args|
    pkg = args[:pkg]
    collection = PKG_TO_COLLECTIONS[pkg] || "openvox#{args[:collection]}"
    cask = pkg
    cask += '-' + args[:collection] if args[:collection]

    os_packages = gather_downloads(collection)
    package_data = gather_checksums(os_packages, collection, pkg)

    source_stanza_erb = ERB.new(File.read(File.join(__dir__, 'templates', 'source_stanza.erb')), trim_mode: '-')
    source_stanza_content = source_stanza_erb.result_with_hash(
      base_url: "#{MACOS_BASE_URL}/#{collection}",
      pkg: pkg,
      package_data: package_data
    )

    cask_erb = ERB.new(File.read(File.join(__dir__, 'templates', "#{cask}.rb.erb")), trim_mode: '-')
    cask_content = cask_erb.result_with_hash(
      source_stanza: source_stanza_content
    )

    File.write(File.join(__dir__, 'Casks', "#{cask}.rb"), cask_content)
  end
end
