class LeafNode

  attr_reader :parent
  attr_reader :name

  def initialize( parent, name )
    @parent = parent
    @name = name
    @path = nil
  end

  def path
    return @path unless @path.nil?
    if @parent.nil?
      @path = @name
    else
      @path = File.join( @parent.path, @name )
    end
    @path
  end

  def to_str
    "item #@name"
  end

end
