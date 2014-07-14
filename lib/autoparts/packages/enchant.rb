module Autoparts
  module Packages
    class Enchant < Package
      name 'enchant'
      version '1.6.0'
      description 'Enchant: a generic spell checking library.'
      category Category::LIBRARIES

      source_url 'http://www.abisource.com/downloads/enchant/1.6.0/enchant-1.6.0.tar.gz'
      source_sha1 '321f9cf0abfa1937401676ce60976d8779c39536'
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
          execute "make install"
        end
      end
    end
  end
end
