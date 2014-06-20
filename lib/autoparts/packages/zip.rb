module Autoparts
  module Packages
    class Zip < Package
      name 'zip'
      version '3.0'
      description 'Zip'
      category Category::LIBRARIES

      source_url 'http://downloads.sourceforge.net/infozip/zip30.tar.gz'
      source_sha1 'c9f4099ecf2772b53c2dd4a8e508064ce015d182'
      source_filetype 'tar.gz'

      def compile
        Dir.chdir('zip30') do
          execute 'make', '-f', 'unix/Makefile', 'generic_gcc'
        end
      end


      def install
        Dir.chdir('zip30') do
          execute 'make', "prefix=#{prefix_path}",  '-f', 'unix/Makefile', 'install'
        end
      end
    end
  end
end
