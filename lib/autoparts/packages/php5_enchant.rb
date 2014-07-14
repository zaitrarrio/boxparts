require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Enchant < Package
      include Php5Ext
      
      name 'php5-enchant'
      description 'enchant module for php5'
      depends_on 'php5'
      depends_on 'enchant'
      
      category Category::WEB_DEVELOPMENT

      def php_extension_name
        'enchant'
      end
      
      def php_compile_args
        ["--with-enchant=#{get_dependency("enchant").prefix_path}"]
      end
    end
  end
end