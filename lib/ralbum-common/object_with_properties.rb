module ObjectWithProperties
  def init_object_with_properties
    @properties = {}
    @properties.default = ""      
  end
  
  def []( key )
    @properties[ key ]
  end
  
  def[]=( key, value )
    @properties[ key ] = value
  end  
end
