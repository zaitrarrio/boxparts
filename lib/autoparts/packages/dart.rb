module Autoparts
  module Packages
    class Dart < Package
      name 'dart'
      version '1.4.3'
      description 'Dart is a new platform for scalable web app engineering'
      source_url 'http://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip'
      source_sha1 '3bfad851d6aa437f0847a80af96af2545539f8b5'
      source_filetype 'zip'
      category Category::PROGRAMMING_LANGUAGES

      def install
        prefix_path.mkpath
        Dir.chdir(extracted_archive_path + 'dart' + 'dart-sdk') do
          execute 'cp', '-r', '.', prefix_path
        end
      end
    end
  end
end

