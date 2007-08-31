
=== Dipendenze
utilizza la libreria abstract di kwartz
gui: dipende da fxruby e/o wxruby

=== TODO


* gui rendere consistenti i treeviewer
  - stessi menu
  - stesso look
  - stesse icone

=== Log

* 2007 08 31
  rinominati molti file per renderli consistenti
  se un file contiene la casse OneTwoThree il file si deve chiamare one_two_three.rb

* 2007 08 30
  aggiunte le gui fxruby e wxruby (preliminari)

* 2007 08 25
  cambiato il dirtreewalker in modo che utizzi gli stessi visitor del treenode

* 2007 08 24
  aggiunto un visitor che rispetta la struttura del treenode

* 2007 08 19
  spezzato il DirTreeProcessor in DirTreeWalker e DirTreeVisitor
  aggiunto al TreeNode il Visitor

* 2007 08 17
  aggiunto dirtreeprocessor