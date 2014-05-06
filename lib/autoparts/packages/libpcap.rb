module Autoparts
  module Packages
    class Libpcap < Package
      name 'libpcap'
      version '1.5.3'
      description 'Libpcap: provides a portable framework for low-level network monitoring. Applications include network statistics collection, security monitoring, network debugging, etc.'
      category Category::UTILITIES

      source_url 'http://www.tcpdump.org/release/libpcap-1.5.3.tar.gz'
      source_sha1 '0d1502d1e46f088f5432d9d16e7fc2619cc33380'
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
