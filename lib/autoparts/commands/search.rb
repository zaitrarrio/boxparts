# Copyright (c) 2013-2014 Irrational Industries Inc. d.b.a. Nitrous.IO
# This software is licensed under the [BSD 2-Clause license](https://raw.github.com/nitrous-io/autoparts/master/LICENSE).

require "autoparts/string"
require 'json'

module Autoparts
  module Commands
    class Search
      def initialize(args, options)
        begin
          Pathname.new("#{PROJECT_ROOT}/lib/autoparts/packages").children.each do |f|
            require "autoparts/packages/#{f.basename.sub_ext('')}" if f.extname == '.rb'
          end
        rescue LoadError
        end

        packages = Package.packages
        if args.length > 0
          searchString = args[0].downcase
          packages = packages.select do |name, package_class|
            package = package_class.new
            (name.downcase.include?(searchString) || package.description.downcase.include?(searchString))
          end
        end

        if packages.length > 0
          list = {}
          packages.each_pair do |name, package_class|
            package = package_class.new
            list["#{name} + #{package.version}"] = { 
              name: name,
              version: package.version,
              category: package.category,
              description: package.description 
            }
          end

          colors_length = ''.bold.magenta.green.length
          # json mode outputs the list as a JSON formatted output.
          if options.include?('--json')
            puts JSON.generate list.values
          else
            return if list.empty?
          end
          
          ljust_length = list.keys.map(&:length).max + ' '.bold.magenta.green.length
          format = "%-#{ljust_length}s %s\n"
          columns = `tput cols`.to_i
          list.sort.map do |packag_name, package|
            name = "#{package[:name]}".bold.magenta + " (#{package[:version]})".green
            description = package[:description];
            if (description.length + ljust_length < columns)
            	printf format, name, description
            else
            	descriptions = split_description description, columns - ljust_length + colors_length - 4
            	descriptions.each do |val|
            		printf format, name, val
                name = ' '.bold.magenta.green
              end
            end
          end
        else
          abort "parts: no package found for \"#{args[0]}\""
        end
      end

      def split_description(description, length)
        words = description.strip.split(' ');
        result = []
        line = ""
        words.each do |word|
          if line.length + word.length > length
            result.push(line)
            line = ""
          end
          if line.length > 0
            line = [line, word].join(' ')
          else
            line = word
          end
        end
        result.push(line) if line.length > 0
        result
      end
    end
  end
end