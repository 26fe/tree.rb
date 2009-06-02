class Numeric
  #
  # ritorna una stringa con le migliaia serparate da <separator>
  # es.: 100000 -> 1.000.000
  #
  #
  # copiata da http://wiki.rubygarden.org/Ruby/page/show/FixNumFormat
  #
  def with_separator( separator = ',', length = 3 )
    splitter = Regexp.compile "(\\d{#{length}})"
    before, after = self.to_s.split('.')
    before = before.reverse.gsub splitter, '\1' + separator
    str = "#{ before.chomp( separator ).reverse }"
    str += ".#{ after }" if after
    return str
  end
end
