# rubygems
require 'rubygems'   # if installed with 'gem install'
require 'abstract'

# common
require "common/dirtreevisitor"
require "common/dirtreewalker"

#
# DirTreeProcessor combina un walker con un visitor
# creata solo per ragioni di compatibilita'
# questa classa andra' rimossa appena aggiornato ralbum
#
class DirTreeProcessor < DirTreeWalker

  def initialize(dirname)
    super(dirname)
  end

  def run
    super( self )
  end

  # processa un file (path completo)
  # il valore di ritorno potrebbe essere utilizzato da ...
  # metodo astratto
  #
  def visit_file( treeNode, filename )
    not_implemented
  end

  def visited_file( treeNode, dirname )
    not_implemented
  end

  def visit_dir( treeNode, dirname )
    not_implemented
  end

  def visited_dir( treeNode, filename )
    not_implemented
  end

end