module Autoparts
  module Packages
    class Libmemcached < Package
      name 'libmemcached'
      version '1.0.18'
      description 'Libmemcached: an open source C/C++ client library and tools for the memcached server '
      category Category::UTILITIES

      source_url 'https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz'
      source_sha1 '8be06b5b95adbc0a7cb0f232e237b648caf783e1'
      source_filetype 'tar.gz'

      def compile
        args = [
          "--prefix=#{prefix_path}",
        ]
        
        Dir.chdir(name_with_version) do
          execute './configure', *args
          execute 'make'
        end
      end


      def install
        Dir.chdir(name_with_version) do
          execute 'make install'
        end
      end
    end
  end
end
