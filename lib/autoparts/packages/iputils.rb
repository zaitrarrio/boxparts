# module Autoparts
#   module Packages
#     class Iputils < Package
#       name 'iputils'
#       version 's20121221'
#       description 'Ip Utils:  a set of small useful utilities for Linux networking. It was originally maintained by Alexey Kuznetsov.'
#       category Category::UTILITIES

#       source_url 'http://www.skbuff.net/iputils/iputils-s20121221.tar.bz2'
#       source_sha1 '4d56d8c75d6a5d58f052e4056e975f01ebab9ba9'
#       source_filetype 'tar.bz2'

#       depends_on 'libpcap'
      
#       def compile        
#         Dir.chdir(name_with_version) do
#           execute 'make'
#         end
#       end


#       def install
#         Dir.chdir(name_with_version) do
#           execute 'cp ping '
#         end
#       end
#     end
#   end
# end
