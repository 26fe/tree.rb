# stdlib
require 'md5'

#
# calcola md5 di file grandi, copiata da usenet
#
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
