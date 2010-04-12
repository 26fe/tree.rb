require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe DirTreeWalker do

  it   do
    dir_tree_walker = DirTreeWalker.new( TEST_DATA )
    dir_tree_walker.ignore_dir( ".svn" )

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename( pathname ) }
    dir_tree_walker.run( visitor )
    accumulator.length.should == 9
    accumulator.sort.should ==  %w{ test_data dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 .dir_with_dot dummy.txt}.sort
  end

  it "ignore_function" do
    dtp = DirTreeWalker.new( "." )

    dtp.ignore(/^\./)
    dtp.ignore_file?( ".thumbnails" ).should be_true
    dtp.ignore_dir?( ".thumbnails" ).should be_true

    dtp.ignore_dir("thumbnails")

    dtp.ignore_dir?( ".thumbnails" ).should be_true
    dtp.ignore_dir?( "thumbnails" ).should be_true
    dtp.ignore_dir?( "pippo" ).should be_false


    dtp.ignore_file("xvpics")

    dtp.ignore_file?( "xvpics" ).should be_true
  end

end


