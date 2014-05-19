module Autoparts
  module Packages
    class Aspcud < Package
      name 'aspcud'
      version '1.9.0-1'
      description 'Aspcud: an experimental solver for package dependencies. A package universe and a request to install, remove or upgrade packages have to be encoded in the CUDF format.'
      category Category::LIBRARIES

      #     compile time deps
#       depends_on "boost"
#       depends_on 're2c'
#       

      depends_on 'gringo'
      depends_on 'clasp'

      source_url 'http://parts.codio.com.s3.amazonaws.com/apscud-1.9.0.tar.gz'
      source_sha1 'adff2ea07bcb6d9fb070ad784578cf53b418e064'
      source_filetype 'tar.gz'

      def compile
        args = [
          '-DCMAKE_BUILD_TYPE=Release',
          "-DCMAKE_INSTALL_PREFIX=#{prefix_path}",
	        '-DCUDF2LP_LOC=cudf2lp',
    	    '-DGRINGO_LOC=gringo',
	        '-DCLASP_LOC=clasp',
          '../..',
        ]

        ENV['BOOST_ROOT'] = get_dependency("boost").prefix_path.to_s

        Dir.chdir(extracted_archive_path + 'aspcud-1.9.0') do
          execute 'mkdir -p build/release'
          Dir.chdir("build/release") do
            execute "cmake", *args
            execute 'make'
          end
        end
      end


      def install
        Dir.chdir(extracted_archive_path + 'aspcud-1.9.0' + 'build/release') do
          execute "make install"
        end
      end
    end
  end
end
