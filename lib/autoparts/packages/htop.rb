module Autoparts
  module Packages
    class Htop < Package
      name 'htop'
      version '1.0.3'
      description 'Htop: an interactive process viewer for Linux. It is a text-mode application (for console or X terminals) and requires ncurses.'
      category Category::UTILITIES

      depends_on 'ncurses'
      
      source_url 'http://hisham.hm/htop/releases/1.0.3/htop-1.0.3.tar.gz'
      source_sha1 '261492274ff4e741e72db1ae904af5766fc14ef4'
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
          execute 'make install'
        end
      end
    end
  end
end
