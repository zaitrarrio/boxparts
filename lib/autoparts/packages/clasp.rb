module Autoparts
  module Packages
    class Clasp < Package
      name 'clasp'
      version '3.0.4'
      description 'Clasp: an answer set solver for (extended) normal and disjunctive logic programs.'
      category Category::LIBRARIES

      source_url 'http://cznic.dl.sourceforge.net/project/potassco/clasp/3.0.4/clasp-3.0.4-x86_64-linux.tar.gz'
      source_sha1 '4248a4e77944acc06b2e38a619ebed3a02a4c4e7'
      source_filetype 'tar.gz'

      def install
        FileUtils.mkdir_p(bin_path)
        Dir.chdir(extracted_archive_path + 'clasp-3.0.4') do
          execute 'cp', 'clasp-3.0.4-x86_64-linux', bin_path + 'clasp'
        end
      end
    end
  end
end
