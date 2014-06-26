# Copyright (c) 2013-2014 Irrational Industries Inc. d.b.a. Nitrous.IO
# This software is licensed under the [BSD 2-Clause license](https://raw.github.com/nitrous-io/autoparts/master/LICENSE).

module Autoparts
  module Packages
    class Rust < Package
      name 'rust'
      version '0.10'
      description 'Rust: A safe, concurrent, practical language'
      category Category::PROGRAMMING_LANGUAGES

      source_url 'http://static.rust-lang.org/dist/rust-0.10-x86_64-unknown-linux-gnu.tar.gz'
      source_sha1 '6c2a7c233912e4a02784f284aa2b24e37c6243d4'
      source_filetype 'tar.gz'

      def install
        Dir.chdir('rust-0.10-x86_64-unknown-linux-gnu') do
          execute './install.sh', "--prefix=#{prefix_path}"
        end
      end
    end
  end
end
