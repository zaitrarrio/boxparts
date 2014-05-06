module Autoparts
  module Packages
    class Bison < Package
      name 'bison'
      version '3.0.2'
      description 'Bison: a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
      category Category::UTILITIES

      source_url 'http://ftp.gnu.org/gnu/bison/bison-3.0.2.tar.xz'
      source_sha1 'aeb1e3544007124009e5203afe86a5676580d444'
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
          execute 'make install'
        end
      end
    end
  end
end
