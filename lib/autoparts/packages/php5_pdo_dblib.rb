require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5PdoDblib < Package
      include Php5Ext

      name 'php5-pdo-dblib'
      description 'PDO DBLib module for php5'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'
      depends_on 'freetds'
      
      def php_extension_name
        'pdo_dblib'
      end
      
      def php_compile_args
        [ "--with-pdo-dblib=#{get_dependency("freetds").prefix_path}" ]
      end
      
    end
  end
end