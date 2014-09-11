module Autoparts
  module Packages
    class Freetds < Package
      name 'freetds'
      version '0.91'
      description %{FreeTDS: a set of libraries for Unix and Linux that allows your programs to natively 
                    talk to Microsoft SQL Server and Sybase databases.}
      source_url 'ftp://ftp.freetds.org/pub/freetds/stable/freetds-stable.tgz'
      source_sha1 '3ab06c8e208e82197dc25d09ae353d9f3be7db52'
      source_filetype 'tar.gz'
      category Category::LIBRARIES

      def install
        Dir.chdir(name_with_version) do
          execute 'make', 'install'
        end
      end
      
      def compile
        Dir.chdir(name_with_version) do
          args = [
            "--prefix=#{prefix_path}",
            '--enable-msdblib'
          ]
          execute './configure',  *args
          execute 'make'
        end
      end

    end
  end
end
