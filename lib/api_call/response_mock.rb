class Response
  def initialize(body: )
    @body = body
  end

  def body
    @body.to_json
  end
end