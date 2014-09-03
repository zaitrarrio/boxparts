require 'autoparts/packages/php5_ext'


module Autoparts
  module Packages
    class Php5Phalcon < Package
      include Php5Ext

      name 'php5-phalcon'
      version '1.3.2'
      description 'Phalcon web framework.'
      source_url 'https://github.com/phalcon/cphalcon/archive/phalcon-v1.3.2.tar.gz'
      source_sha1 '64eea8e384363a5582a59a910b1327dc97b7d355'
      source_filetype 'tar.gz'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'

      def php_extension_name
         "phalcon"
      end

      def php_extension_dir
         "cphalcon-phalcon-v1.3.2/build/64bits"
      end

      def php_compile_args
         ['--enable-phalcon']
      end
    end
  end
end
