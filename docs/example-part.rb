module Autoparts
  module Packages
    class MySQL < Package
      name 'mysql' # The name of your Box Part (lower case)
      version '5.6.13' # Version of the component that will be  installed.

      description "MySQL: The world's most popular open-source relational database"

      # Include a category for your part. A list of categories can be found in lib/autoparts/category.rb
      category Category::DATA_STORES

      # The url of the source archive
      source_url 'http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.13.tar.gz'

      # The sha1 hash of this source
      source_sha1 '06e1d856cfb1f98844ef92af47d4f4f7036ef294'

      # 'tar.gz' or 'zip'
      # Other filetypes are simply copied over without extraction.
      source_filetype 'tar.gz'

      ## Dependencies
      depends_on 'php5' 
      # ^^ Not actually needed for MySQL, but added as an example.

      ## Optional compilation step
      def compile
        Dir.chdir('mysql-5.6.13') do
          args = [
            '.',
            "-DCMAKE_INSTALL_PREFIX=#{prefix_path}",
            "-DDEFAULT_CHARSET=utf8",
            "-DDEFAULT_COLLATION=utf8_general_ci",
            "-DINSTALL_MANDIR=#{man_path}",
            "-DINSTALL_DOCDIR=#{doc_path}",
            "-DINSTALL_INFODIR=#{info_path}",
            "-DINSTALL_MYSQLSHAREDIR=#{share_path.basename}/#{name}",
            "-DMYSQL_DATADIR=#{Path.var}/mysql",
            "-DSYSCONFDIR=#{Path.etc}",
            "-DWITH_READLINE=yes",
            "-DWITH_SSL=yes",
            "-DWITH_UNIT_TESTS=OFF"
          ]

          execute 'cmake', *args
          execute 'make'
        end
      end

      # Main installation step
      def install
        Dir.chdir('mysql-5.6.13') do
          execute 'make install'
          execute 'rm', '-rf', mysql_server_path
          execute 'ln', '-s', "#{prefix_path}/support-files/mysql.server", "#{bin_path}/"
          execute 'rm', '-rf', "#{prefix_path}/data"
          execute 'rm', '-rf', "#{prefix_path}/mysql-test"
        end
      end

      ## Post Install
      def post_install
        unless (mysql_var_path + 'mysql' + 'user.frm').exist?
          mysql_var_path.rmtree if mysql_var_path.exist?
          ENV['TMPDIR'] = nil
          args = [
            "--basedir=#{prefix_path}",
            "--datadir=#{mysql_var_path}",
            "--tmpdir=/tmp",
            "--user=#{user}",
            '--verbose'
          ]
          execute "scripts/mysql_install_db", *args
        end
      end

			def required_env
				[
          "export MYSQL_TCP_PORT=3306",
        ]
      end      
      
      def mysql_executable_path
        Path.bin + 'mysql'
      end

      def mysql_server_path
        bin_path + 'mysql.server'
      end

      def mysql_var_path
        Path.var + 'mysql'
      end


      ## Starting and Stopping the part
      #
      # Some parts run as a service. If your part needs to run in the background
      # then you will need to implement start and stop commands.
      def start
        execute mysql_server_path, 'start'
      end

      def stop
        execute mysql_server_path, 'stop'
      end

      # If using start and stop commands, include a 'running?' method.
      # For non Ruby-ists, the !! forces a boolean result
      def running?
        !!system(mysql_server_path.to_s, 'status', out: '/dev/null', err: '/dev/null')
      end

      # Uninstall and then purge additional components
      def purge
        mysql_var_path.rmtree if mysql_var_path.exist?
      end
      
      ## Tips
      def tips
        <<-STR.unindent
          To start the server:
            $ parts start mysql

          To stop the server:
            $ parts stop mysql

          To connect to the server:
            $ mysql
        STR
      end
    end
  end
end