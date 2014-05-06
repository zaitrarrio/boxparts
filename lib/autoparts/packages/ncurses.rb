module Autoparts
  module Packages
    class Ncurses < Package
      name 'ncurses'
      version '5.9'
      description 'Ncurses: a free software emulation of curses in System V Release 4.0, and more.'
      category Category::LIBRARIES

      source_url 'http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz'
      source_sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'
      source_filetype 'tar.gz'

      def compile
        args = [
          "--prefix=#{prefix_path}",
          '--with-shared',
          '--enable-widec',
#          '--enable-pc-files',
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
