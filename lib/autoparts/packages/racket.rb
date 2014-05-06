module Autoparts
  module Packages
    class Racket < Package
      name 'racket'
      version '6.0'
      description ''
      category Category::PROGRAMMING_LANGUAGES

      source_url 'http://mirror.racket-lang.org/installers/6.0/racket-6.0-src-unix.tgz'
      source_sha1 '1d08758ed2278681f8c97b2872417b963183d5c9'
      source_filetype 'tgz'

      def compile
        Dir.chdir(name_with_version + '/src') do
          args = [
            "--prefix=#{prefix_path}",
          ]
          execute './configure', *args
          execute 'make'
        end
      end


      def install
        Dir.chdir(name_with_version + '/src') do
          execute 'make install'
        end
      end
    end
  end
end
