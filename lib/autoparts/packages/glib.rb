module Autoparts
  module Packages
    class Glib < Package
      name 'glib'
      version '2.40.0'
      description 'GLib: a general-purpose utility library, which provides many useful data types, macros, type conversions, string utilities, file utilities, a mainloop abstraction, and so on.'
      category Category::LIBRARIES

      depends_on 'libffi'

      source_url 'http://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.0.tar.xz'
      source_sha1 '44e1442ed4d1bf3fa89138965deb35afc1335a65'
      source_filetype 'tar.xz'

      def compile
        Dir.chdir(name_with_version) do
          args = [
            "--prefix=#{prefix_path}",  
            "--disable-maintainer-mode",
            "--disable-dependency-tracking",
            "--disable-silent-rules",
#           "--disable-dtrace",
            "--disable-libelf",
          ]

          execute './configure', *args
          execute 'make -j1'
        end
      end


      def install
        Dir.chdir(name_with_version) do
          execute 'make install'
        end
      end
    end
  end
end
