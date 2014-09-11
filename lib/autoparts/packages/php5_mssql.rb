require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Mssql < Package
      include Php5Ext

      name 'php5-mssql'
      description 'MsSQL module for php5'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'
      depends_on 'freetds'
      
      def php_extension_name
        'mssql'
      end
      
      def php_compile_args
        [ "--with-mssql=#{get_dependency("freetds").prefix_path}" ]
      end
      
    end
  end
end