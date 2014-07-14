require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Apcu < Package
      include Php5Ext

      name 'php5-apcu'
      category Category::WEB_DEVELOPMENT

      version '4.0.6'
      description 'PHP APC User Cache'
      source_url 'http://pecl.php.net/get/apcu-4.0.6.tgz'
      source_sha1 'f4841f20b333638381b3180ffa1f66b69de1de0f'
      source_filetype 'tgz'

      depends_on 'php5'

      def php_extension_name
        "apcu"
      end

      def php_extension_dir
        "apcu-4.0.6"
      end

    end
  end
end
