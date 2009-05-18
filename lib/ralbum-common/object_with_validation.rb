# Classe astratta
# Oggetto che si valida, contiene all'interno la lista
# di messaggi che spiegano perche' non e' valido
#
# la classe derivata deve definire il metodo validate
#
class ObjectWithValidation

  def initialize
    @valid = true
    # @explain = []
    # puts "base initialize"
  end

  def valid?
    @valid
  end

  def invalid?
    not valid?
  end

  def force_validate
    validate
    @valid
  end

  def explain
    raise "Valid object" if valid?
    @explain
  end

  protected

  def add_error( msg )
    @valid = false
    @explain ||= []

    if msg.class == String
      @explain << msg
    end

    if msg.class == Array
      msg.each { |ex|
        add_error("Invalid image_file nested message: '#{ex}'")
      }
    end
  end

end
