# requires scons for build, and the latest gcc
# 
module Autoparts
  module Packages
    class Gringo < Package
      name 'gringo'
      version '4.3.0'
      description 'Gringo: a grounder that, given an input program with first-order variables, computes an equivalent ground (variable-free) program.'
      category Category::LIBRARIES

#       depends_on 'bison'
#       depends_on 're2c'
      
      source_url 'http://optimate.dl.sourceforge.net/project/potassco/gringo/4.3.0/gringo-4.3.0-x86_64-linux.tar.gz'
      source_sha1 '843e4548464e51781190a03431a6d9cc6c426837'
      source_filetype 'tar.gz'

      def compile

      end


      def install
        Dir.chdir(extracted_archive_path + 'gringo-4.3.0-x86_64-linux') do
          bin_path.mkpath
          execute 'cp', "gringo", bin_path
        end
      end
    end
  end
end
