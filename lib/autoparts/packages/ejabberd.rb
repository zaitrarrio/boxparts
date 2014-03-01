module Autoparts
  module Packages
    class EJabber < Package
      name 'ejabberd'
      version '13.12'
      description 'ejabberd is a Jabber/XMPP instant messaging server'
      source_url 'http://www.process-one.net/downloads/downloads-action.php?file=/ejabberd/13.12/ejabberd-13.12.tgz'
      source_sha1 '3aedb5012fab49181961ff24bad3af581f4b30ee'
      source_filetype 'tgz'

      depends_on 'erlang'

      def install
        prefix_path.mkpath
        Dir.chdir(extracted_archive_path + name_with_version) do

        args = [
            "--prefix=#{prefix_path}",
            "--enable-all",
            "--enable-user=codio",
            "--disable-odbc",
          ]

          execute './configure', *args
          execute 'make'
        end
      end

      def start
        execute sbin_path + "rabbitmq-server", "-detached"
      end

      def stop
        execute sbin_path + "rabbitmqctl", "stop"
      end

      def running?
        !!system((sbin_path + "rabbitmqctl").to_s, "status", out: '/dev/null', err: '/dev/null')
      end

      def tips
        <<-EOS.unindent
          To start the Rabbitmq server:
            $ parts start rabbitmq

          To stop the Rabbitmq server:
            $ parts stop rabbitmq

          Rabbitmq config is located at:
            $ #{rabbitmq_conf_path}
        EOS
      end

      def rabbitmq_conf_path
        Path.etc + 'rabbitmq/'
      end
    end
  end
end
