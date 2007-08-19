class DirTreeVisitor

  # processa un file (path completo)
  # il valore di ritorno potrebbe essere utilizzato da ...
  # metodo astratto
  #
  def visit_file( treeNode, filename )
    # not_implemented
  end

  def visited_file( treeNode, dirname )
    # not_implemented
  end

  def visit_dir( treeNode, dirname )
    # not_implemented
  end

  def visited_dir( treeNode, filename )
    # not_implemented
  end

end
