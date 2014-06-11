module Autoparts
  module Packages
    class Jruby < Package
      name 'jruby'
      version '1.7.12'
      description 'jRuby: The Ruby Programming Language on the JVM'
      category Category::PROGRAMMING_LANGUAGES

      source_url 'http://jruby.org.s3.amazonaws.com/downloads/1.7.12/jruby-bin-1.7.12.tar.gz'
      source_sha1 '056cee1138e49da40a77f179b771372692479002'
      source_filetype 'tar.gz'

      def install
        prefix_path.mkpath
        Dir.chdir(name_with_version) do
          execute 'cp', '-r', '.', prefix_path
        end
      end
    end
  end
end
