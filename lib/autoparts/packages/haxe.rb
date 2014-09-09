module Autoparts
  module Packages
    class Haxe < Package
    	name 'haxe'
      version '3.1.3'
      description 'Haxe: an open source toolkit.'
      source_url 'http://haxe.org/website-content/downloads/3,1,3/downloads/haxe-3.1.3-linux64.tar.gz'
      source_sha1 '590f2558dd1fa283f21c87cf086dd0a2f8beccc3'
      source_filetype 'tar.gz'
      category Category::DEPLOYMENT

      depends_on 'neko'
      
      def install
        bin_path.mkpath
        lib_path.mkpath
        Dir.chdir(extracted_archive_path + name_with_version) do
          execute 'cp', '-r', '.', lib_path
          execute 'mv', lib_path + 'haxe', bin_path
          execute 'mv', lib_path + 'haxelib', bin_path
        end
      end
      
      def required_env
        [
          "export HAXE_STD_PATH=#{lib_path}/std",
        ]
      end
      
      def tips
        <<-EOS.unindent

        Close and open terminal to have #{name} working after the install.
         or reload shell with
         . ~/.bash_profile
        EOS
      end
    end
  end
end

