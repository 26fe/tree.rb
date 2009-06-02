#
# calculate md5 of big files, found on usenet
#

if RUBY_VERSION =~ /1\.8/
  # stdlib
  require 'md5'
else
  # stdlib
  require 'digest/md5'
  include Digest
end

class MD5
  def self.file(file)
    File.open(file, "rb") do |f|
      res = self.new
      while (data = f.read(4096))
        res << data
      end
      res
    end
  end
end
