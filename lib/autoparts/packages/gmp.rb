module Autoparts
  module Packages
    class Gmp < Package
      name 'gmp'
      version '6.0.0'
      description 'GMP: a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
      category Category::LIBRARIES

      source_url 'https://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz'
      source_sha1 '1aaf78358ab9e34aeb61f3ae08174ee9118ece98'
      source_filetype 'tar.xz'

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
