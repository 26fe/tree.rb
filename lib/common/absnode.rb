class AbsNode

  attr_reader :parent
  attr_reader :name

  def initialize( name )
    @parent = nil
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

  protected

  def parent=( parent )
    @parent = parent
  end

end
