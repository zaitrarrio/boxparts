require 'autoparts/packages/php5_ext'

module Autoparts
  module Packages
    class Php5Memcached < Package
      include Php5Ext

      name 'php5-memcached'
      version '2.2.0'
      description 'Memcached module for php5'
      source_url 'http://pecl.php.net/get/memcached-2.2.0.tgz'
      source_sha1 '402d7c4841885bb1d23094693f4051900f8f40a8'
      source_filetype 'tgz'
      category Category::WEB_DEVELOPMENT

      depends_on 'php5'

      depends_on 'libmemcached'
      
      def php_extension_name
        "memcached"
      end

      def php_extension_dir
        php_extension_name + '-' + version
      end
			
      def php_compile_args
        [
          "--with-libmemcached-dir=#{get_dependency("libmemcached").prefix_path}",
          "--disable-memcached-sasl"
        ]
      end
    end
  end
end
