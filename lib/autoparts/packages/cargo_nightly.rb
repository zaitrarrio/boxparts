# Copyright (c) 2013-2014 Irrational Industries Inc. d.b.a. Nitrous.IO
# This software is licensed under the [BSD 2-Clause license](https://raw.github.com/nitrous-io/autoparts/master/LICENSE).

module Autoparts
  module Packages
    class RustNightly < Package
      name 'cargo-nightly'
      version '0.0.1-pre-nightly-29e6a4f_2014-09-17'
      description 'Cargo build and dependency manager for Rust'
      category Category::DEVELOPMENT_TOOLS

      source_url 'https://static.rust-lang.org/cargo-dist/cargo-nightly-x86_64-unknown-linux-gnu.tar.gz'
      source_sha1 '5cd677489720f7015f8b591a42dbda2556b984f6'
      source_filetype 'tar.gz'

      def install
        Dir.chdir('cargo-nightly-x86_64-unknown-linux-gnu') do
          execute './install.sh', "--prefix=#{prefix_path}"
        end
      end
    end
  end
end

