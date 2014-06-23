# Copyright (c) 2013-2014 Irrational Industries Inc. d.b.a. Nitrous.IO
# This software is licensed under the [BSD 2-Clause license](https://raw.github.com/nitrous-io/autoparts/master/LICENSE).

module Autoparts
  module Packages
    class Sbt < Package
      name 'sbt'
      version '0.13.5'
      description 'Sbt: An interactive build tool for scala'
      category Category::UTILITIES

      source_url 'http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.5/sbt-launch.jar'
      source_sha1 'f6308bd94bebdd37eb5e2fda732694ce0f34be74'
      source_filetype 'jar'

      
      def install
        bin_path.mkpath
        execute 'mv', archive_filename, bin_path + 'sbt-launch.jar'
        File.open(sbt_exec_path, 'w') do |f|
        	f.write sbt_exec
        end
        execute 'chmod', '+x', sbt_exec_path
        sbt_real_home.mkpath
        creates_home_link
        #init
        execute sbt_exec_path, 'help'
        remove_home_link
      end
      
      def post_install
        creates_home_link
      end
      
      def post_uninstall
        remove_home_link
      end
      
      def remove_home_link
         sbt_home.unlink if sbt_home.symlink?
      end
      
      def creates_home_link
        execute 'ln', '-s', sbt_real_home, sbt_home
      end
      
      def sbt_home
        Path.home + '.sbt'
      end
      
      def sbt_real_home
        prefix_path + '.sbt'
      end
      
      def sbt_exec_path
      	bin_path + 'sbt'
      end
      
      def sbt_exec
        <<-EOF.unindent
        	SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
          java $SBT_OPTS -jar #{bin_path}/sbt-launch.jar "$@"
        EOF
      end
    end
  end
end
