require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Xsl < Package
      include Php5Ext

      name 'php5-xsl'
      description 'XSL module for php5'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'

      def php_extension_name
        'xsl'
      end

    end
  end
end