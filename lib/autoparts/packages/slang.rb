module Autoparts
  module Packages
    class Slang < Package
      name 'slang'
      version '2.2.4'
      description 'Slang: a multi-platform programmer\'s library designed to allow a developer to create robust multi-platform software.'
      category Category::LIBRARIES

      source_url 'ftp://ftp.ntua.gr/pub/lang/slang/slang/v2.2/slang-2.2.4.tar.bz2'
      source_sha1 '34e68a993888d0ae2ebc7bc31b40bc894813a7e2'
      source_filetype 'tar.bz2'

      def compile
        Dir.chdir(name_with_version) do
          args = [
            "--prefix=#{prefix_path}",
          ]
          execute './configure', *args
          ENV.delete 'MAKEFLAGS'
          execute 'make'
        end
      end


      def install
        Dir.chdir(name_with_version) do
          ENV.delete 'MAKEFLAGS'
          execute 'make install'
        end
      end
    end
  end
end
