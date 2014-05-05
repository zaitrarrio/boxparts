module Autoparts
  module Packages
    class Libffi < Package
      name 'libffi'
      version '3.0.13'
      description 'Libffi: A Portable Foreign Function Interface Library'
      category Category::LIBRARIES

      source_url 'ftp://sourceware.org/pub/libffi/libffi-3.0.13.tar.gz'
      source_sha1 'f5230890dc0be42fb5c58fbf793da253155de106'
      source_filetype 'tar.gz'

      def compile
        Dir.chdir(name_with_version) do
          args = [
            "--prefix=#{prefix_path}",
            "--disable-debug", 
            "--disable-dependency-tracking",
          ]
          execute './configure', *args
          execute 'make -j1'
        end
      end


      def install
        Dir.chdir(name_with_version) do
          execute 'make install'
          execute 'make check'          
        end
      end
    end
  end
end
