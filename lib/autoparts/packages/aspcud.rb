module Autoparts
  module Packages
    class Aspcud < Package
      name 'aspcud'
      version '1.9.0'
      description 'Aspcud: an experimental solver for package dependencies. A package universe and a request to install, remove or upgrade packages have to be encoded in the CUDF format.'
      category Category::LIBRARIES

      depends_on "boost"
      depends_on 're2cac'
      source_url 'http://cznic.dl.sourceforge.net/project/potassco/aspcud/1.9.0/aspcud-1.9.0-source.tar.gz'
      source_sha1 'ae77772c2424620b3064d0dfe795c26b1c8aa778'
      source_filetype 'tar.gz'

      def compile
        args = [
          '-DCMAKE_BUILD_TYPE=Release',
          '../..',
          "-DCMAKE_INSTALL_PREFIX=#{prefix_path}",
        ]
        
        ENV['BOOST_ROOT'] = get_dependency("boost").prefix_path.to_s
        
        Dir.chdir(name_with_version + "-source") do
          execute 'mkdir -p build/release'
          Dir.chdir("build/release") do
            execute "cmake", *args
            execute 'make'
          end
        end
      end


      def install
        Dir.chdir(name_with_version + "-source/build/release") do
          execute 'make install'
        end
      end
    end
  end
end
