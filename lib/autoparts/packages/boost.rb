module Autoparts
  module Packages
    class Boost < Package
      name 'boost'
      version '1.55.0'
      description 'Boost: a free peer-reviewed portable C++ source libraries.'
      category Category::LIBRARIES

      source_url 'http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.bz2/download'
      source_sha1 'cef9a0cc7084b1d639e06cd3bc34e4251524c840'
      source_filetype 'tar.bz2'

      def compile
        Dir.chdir('boost_1_55_0') do
          args = [
            "--prefix=#{prefix_path}",
          ]
          execute 'sh', 'bootstrap.sh', *args
          execute './b2'
        end
      end


      def install
        Dir.chdir('boost_1_55_0') do
          execute './b2 install'
        end
      end
    end
  end
end
