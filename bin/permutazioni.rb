#
# Calcola le permutazioni di un array
# test di colloquio a venere
#

require 'pp'

$count = 0

class Array
  def del el
    a = dup
    self.each_with_index { |e,i| 
      if e == el
        a.delete_at(i)
        break
      end
    }
    a
  end
end


def permute( s, seq )
  #puts "permute #{s.join} #{seq.join}"
  if s.length == 1
    seq << s[0]
    puts seq.join
    $count += 1
    return
  end
  s1 = s.uniq
  s1.each { |e|
    seq1 = seq.dup
    seq1 << e
    permute( s.del(e), seq1 )
  }
end

a = ['a', 'b', 'c', 'a']
permute(a, [] )
puts "totale permutazioni #{$count}"
