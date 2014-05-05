module Autoparts
  module Packages
    class Mc < Package
      name 'mc'
      version '4.8.12'
      description 'GNU Midnight Commander: a visual file manager'
      category Category::UTILITIES
      
      source_url 'http://ftp.midnight-commander.org/mc-4.8.12.tar.bz2'
      source_sha1 '50a95e5e4d272f7cf7821febe238e4e6d4209f34'
      source_filetype 'tar.bz2'

      depends_on 'glib'
      depends_on 'slang'
      
      def compile
        Dir.chdir(name_with_version) do
          args = [
            "--prefix=#{prefix_path}"
          ]

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
