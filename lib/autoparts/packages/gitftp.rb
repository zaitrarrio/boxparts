 
module Autoparts
  module Packages
    class Gitftp < Package
      name 'gitftp'
      version '0.9.0'
      description 'Gitftp: a git powered FTP client written as shell script.'
      category Category::UTILITIES
      
      source_url 'https://github.com/git-ftp/git-ftp/archive/0.9.0.zip'
      source_sha1 '3c7dc9319d10bf28a07e27d07801f279ee30528b'
      source_filetype 'zip'

      def install
        Dir.chdir('git-ftp-0.9.0') do
          ENV['DESTDIR'] = prefix_path.to_s
          execute 'make install'
        end
      end
    end
  end
end
