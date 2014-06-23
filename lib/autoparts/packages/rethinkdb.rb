module Autoparts
  module Packages
    class Rethinkdb < Package
      name 'rethinkdb'
      version '1.13'
      description 'RethinkDB: An open-source distributed database built with love.'
      category Category::DATA_STORES

      source_url 'https://github.com/rethinkdb/rethinkdb/archive/v1.13.x.zip'
      source_sha1 '7c0ac576a9e9e2200d96bb0db9ca015fd4d6c9d1'
      source_filetype 'zip'

      depends_on 'protobuf'
      
      def compile
        Dir.chdir("rethinkdb-1.13.x") do
          args = [
            "--allow-fetch",
            "--prefix=#{prefix_path}",
          ]
          execute './configure', *args
          execute 'make'
        end
      end

      def etc_path
        prefix_path + 'etc'
      end
      
      
      def post_install
        etc_path.mkpath
        execute 'cp', '-r', etc_path + 'rethinkdb', Path.etc
        execute 'cp', Path.etc + 'rethinkdb' + 'default.conf.sample', default_conf
        execute 'sed', '-i', "s|rtdbbin=/usr/bin/rethinkdb|rtdbbin=#{rethinkdb_path}|g", init_script
        execute 'sed', '-i', "s|rtdbconfigdir=/etc/rethinkdb|rtdbconfigdir=#{Path.etc + 'rethinkdb'}|g", init_script
        run_dir.mkpath
        lib_dir.mkpath
        log_dir.mkpath
        execute 'sed', '-i', "s|# pid-file=/var/run/rethinkdb/rethinkdb.pid|pid-file=#{run_dir + 'default.pid'}|g", default_conf
        execute 'sed', '-i', "s|# directory=/var/lib/rethinkdb/default|directory=#{lib_dir + 'default'}|g", default_conf
        execute 'sed', '-i', "s|# log-file=/var/log/rethinkdb|log-file=#{log_dir + 'default.log'}|g", default_conf
        execute 'sed', '-i', "s|# runuser=rethinkdb|runuser=#{user}|g", default_conf
        execute 'sed', '-i', "s|# rungroup=rethinkdb|rungroup=#{user}|g", default_conf
      end

      def default_conf
        Path.etc + 'rethinkdb' + 'instances.d/default.conf'
      end
      
      def run_dir
        Path.var + 'rethinkdb' + 'run' 
      end

      def lib_dir
        Path.var + 'rethinkdb' + 'lib' 
      end

      def log_dir
        Path.var + 'rethinkdb' + 'log' 
      end

      
      def init_script
        etc_path + 'init.d' + 'rethinkdb'
      end
      
      def install
        Dir.chdir("rethinkdb-1.13.x") do
          execute 'make', 'install'
        end
      end

      def rethinkdb_path
        bin_path + 'rethinkdb'
      end
      
      def start
        execute init_script, 'start'
      end

      def stop
        execute init_script, 'stop'

      end

      def running?
        `#{init_script} status`.include?('start/running')
      end

      def tips
        <<-EOS.unindent
          
          To start the server:
            $ parts start rethinkdb

          To stop the server:
            $ parts stop rethinkdb

          Configs location: 
            #{Path.etc + 'rethinkdb'}
          DB location: 
            #{lib_dir}
          Logs location: 
            #{log_dir}
        EOS
      end
    end
  end
end
