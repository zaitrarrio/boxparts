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

      def install
				Dir.chdir("rethinkdb-1.13.x") do
        end
      end

      def rethinkdb_path
        prefix_path + 'rethinkdb'
      end
      
      def start
        execute rethinkdb_path
      end

      def stop

      end

      def running?
        if mongod_pid_file_path.exist?
          pid = File.read(mongod_pid_file_path).strip
          if pid.length > 0 && `ps -o cmd= #{pid}`.include?(mongod_path.basename.to_s)
            return true
          end
        end
        false
      end

      def tips
        <<-EOS.unindent
          To start the server:
            $ parts start rethinkdb

          To stop the server:
            $ parts stop rethinkdb

        EOS
      end
    end
  end
end
