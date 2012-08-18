# -*- coding: utf-8 -*-

if RUBY_VERSION =~ /1\.8/
  # std lib
  require 'md5'
else
  # std lib
  require 'digest/md5'
  require 'digest/sha1'
  include Digest
end

# Return an MD5 object
# example:
# MD5.file( filename ).hexdigest
#
class MD5
  # calculate md5 of big files, snipped found on usenet
  def self.file(file)
    File.open(file, "rb") do |f|
      digest = self.new
      while (data = f.read(4096))
        digest << data
      end
      digest
    end
  end
end


class SHA1
  # Create a hash digest for the file.
  def self.file(file)
    digest = self.new
    File.open(file, 'r') do |handle|
      while (data = handle.read(1024))
        digest << data
      end
    end
    digest
  end
end
