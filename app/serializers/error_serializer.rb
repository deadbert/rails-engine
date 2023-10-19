class ErrorSerializer 

  def initialize(error_object)
    @error_object = error_object
  end

  def serialize_error
    {
      errors: [
        {
          status: @error_object.status.to_s, 
          message: @error_object.message
        }
      ]
    }
  end
end