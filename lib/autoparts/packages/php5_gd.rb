require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Gd < Package
      include Php5Ext

      name 'php5-gd'
			version '5.5.10-2'
      description 'GD module for php5'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'
      depends_on 'freetype'
      
      def php_extension_name
        'gd'
      end

      def php_compile_args
        [
          "--with-jpeg-dir",
          "--with-png",
          # "--with-freetype-dir",
          "--with-freetype-dir=#{get_dependency('freetype').prefix_path}",
          "--with-xpm",
          "--with-freetype",
          "--enable-gd-native-ttf",
        ]
      end
    end
  end
end