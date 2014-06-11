require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Mongo < Package
      include Php5Ext

      name 'php5-mongo'
      category Category::WEB_DEVELOPMENT

      version '1.5.3'
      description 'Mongo driver for php5'
      source_url 'http://pecl.php.net/get/mongo-1.5.3.tgz'
      source_sha1 '6515519d82aee17c1a2ebcb7005c7d6400893d5a'
      source_filetype 'tgz'

      depends_on 'php5'

      def php_extension_name
        "mongo"
      end

      def php_extension_dir
        "mongo-1.5.3"
      end

    end
  end
end
