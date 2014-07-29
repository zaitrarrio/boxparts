require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
      class Php5Sockets < Package
      include Php5Ext

      name 'php5-sockets'
      description 'Sockets module for php5'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'

      def php_extension_name
        'sockets'
      end

    end
  end
end