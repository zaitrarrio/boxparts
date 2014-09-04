# Copyright (c) 2013-2014 Irrational Industries Inc. d.b.a. Nitrous.IO
# This software is licensed under the [BSD 2-Clause license](https://raw.github.com/nitrous-io/autoparts/master/LICENSE).

# All python packages should be rebuild on version change.
module Autoparts
  module Packages
    class Python2 < Package
      name 'python2'
      version '2.7.8'
      description 'Python 2: The most friendly Programming Language'
      source_url 'http://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz'
      source_sha1 '511960dd78451a06c9df76509635aeec05b2051a'
      source_filetype 'tgz'
      category Category::PROGRAMMING_LANGUAGES

      #depends_on 'sqlite3'
      
      def compile
        Dir.chdir(python_version) do
          args = [
            "--prefix=#{prefix_path}",
            "--enable-shared",
            "--enable-loadable-sqlite-extensions"
          ]
          pre_compile
          execute "./configure", *args
          execute "make"
        end
      end
      
      def pre_compile
		execute 'sed', '-i', "1098 c\\        sqlite_inc_paths = [ '/usr/include', '#{Path.include}', ", 'setup.py'
      end
      
      def install
        Dir.chdir(python_version) do
          execute "make install"
        end
      end

      def python_version
        "Python-2.7.8"
      end

      def site_packages
        p = prefix_path + "lib" + "python#{common_version}" + "site-packages"
        p.mkpath unless p.exist?
        p
      end
      
      def common_version
        "2.7"
      end

      # we want to cleanup site-packages to make sure that we dont include any
      # wrong packages
      def pre_archive
        FileUtils.rm_rf site_packages
        site_packages
      end
    end
  end
end
