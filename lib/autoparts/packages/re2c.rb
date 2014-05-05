module Autoparts
  module Packages
    class Re2c < Package
      name 're2c'
      version '0.13.6'
      description 'Re2C: a tool for writing very fast and very flexible scanners.'
      category Category::LIBRARIES

      source_url 'http://sourceforge.net/projects/re2c/files/re2c/0.13.6/re2c-0.13.6.tar.gz/download'
      source_sha1 'b272048550db56aea2ec1a0a1bce759b90b778fa'
      source_filetype 'tar.gz'

      def compile
        Dir.chdir(name_with_version) do
          args = [
            "--prefix=#{prefix_path}",
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
