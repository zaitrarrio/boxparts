# Copyright (c) 2013-2014 Irrational Industries Inc. d.b.a. Nitrous.IO
# This software is licensed under the [BSD 2-Clause license](https://raw.github.com/nitrous-io/autoparts/master/LICENSE).

# All python packages should be rebuild on version change.
module Autoparts
  module Packages
    class Virtualenv < Package
      name 'virtualenv'
      version '1.11.6'
      description 'Virtualenv: Virtual Python Environment builder'
      source_url 'https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.11.6.tar.gz'
      source_sha1 'd3f8e94bf825cc999924e276c8f1c63b8eeb0715'
      source_filetype 'tgz'
      category Category::DEVELOPMENT_TOOLS

      depends_on "python2"

      def compile
        Dir.chdir("virtualenv-1.11.6") do
          args = [
            "-s", "setup.py",
            "--no-user-cfg",
            "install",
            "--force", "--verbose",
            "--prefix=#{prefix_path}",
            "--install-lib=#{python_dependency.site_packages}"
          ]

          execute python_dependency.bin_path + "python", *args
        end
      end

      def python_dependency
        @python ||= get_dependency("python2")
      end
    end
  end
end
