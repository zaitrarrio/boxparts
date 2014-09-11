module Autoparts
  module Packages
    class Neko < Package
      name 'neko'
      version '2.0.0'
      description 'Neko: high-level dynamicly typed programming language.'
      source_url 'http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz'
      source_sha1 '4725f8a762e7184ff07938f749fa9d0f1caafb19'
      source_filetype 'tar.gz'
      category Category::PROGRAMMING_LANGUAGES

      def binaries
        [
          'neko',
          'nekoc',
          'nekoml'
        ]
      end
      
      def neko_libs
        lib_path + 'neko'
      end
      
      def install
        bin_path.mkpath
        neko_libs.mkpath
        Dir.chdir(extracted_archive_path + 'neko-2.0.0-linux') do
          binaries.each do |val|
            execute 'mv', val, bin_path
          end
          execute 'cp', '-r', '.', neko_libs
        end
      end      
      
      def required_env
        [
          "export NEKOPATH=#{neko_libs}",
          "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:#{neko_libs}",
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

