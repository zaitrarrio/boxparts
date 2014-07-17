module Autoparts
  module Packages
    class Ghc < Package
      name 'ghc'
      version '7.8.3'
      description 'Glasgow Haskell Compiler: a state-of-the-art, open source, compiler and interactive environment for the functional language Haskell.'
      category Category::PROGRAMMING_LANGUAGES

      source_url 'http://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-x86_64-unknown-linux-deb7.tar.xz'
      source_sha1 'bdca218494cc122eba6939b00bccdc820e68b501'
      source_filetype 'tar.xz'

      def compile
        Dir.chdir('ghc-7.8.3') do
         args = [
            "--prefix=#{prefix_path}"
          ]
          execute './configure', *args
        end
      end

      def install
        Dir.chdir('ghc-7.8.3') do
          execute 'make', 'install'
        end
      end
    end
  end
end
