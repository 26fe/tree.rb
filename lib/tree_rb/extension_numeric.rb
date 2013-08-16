# -*- coding: utf-8 -*-
class Numeric
  #
  # returns a string separated by the thousands <separator>
  # es.: 100000 -> 1.000.000
  #
  def with_separator(separator = ',', length = 3)
    splitter      = Regexp.compile "(\\d{#{length}})"
    before, after = self.to_s.split('.')
    before        = before.reverse.gsub splitter, '\1' + separator
    str           = "#{ before.chomp(separator).reverse }"
    str += ".#{ after }" if after
    str
  end

  def to_human
    if self == 0
      return '0B'
    end
    units = %w{B KB MB GB TB}

    e     = (Math.log(self)/Math.log(1024)).floor
    s     = '%.3f' % (to_f / 1024**e)
    s.sub(/\.?0*$/, units[e])
  end

end
