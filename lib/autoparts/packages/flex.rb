module Autoparts
  module Packages
    class Flex < Package
      name 'flex'
      version '2.5.39'
      description 'Flex: a tool for generating scanners: programs which recognize lexical patterns in text.'
      category Category::UTILITIES

      source_url 'http://downloads.sourceforge.net/project/flex/flex-2.5.39.tar.xz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fflex%2Ffiles%2F&ts=1399309752&use_mirror=softlayer-ams'
      source_sha1 '415e82bb0dc9b1713fc4802a9db2274cd8d2909a'
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
