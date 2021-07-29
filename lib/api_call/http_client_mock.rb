class Response
  def body
    { status: "paid" }.to_json
  end
end

class HttpClientMock
  @@requests = []

  def post(url:, params:, headers:)
    new_request = {
      url: url,
      params: params,
      headers: headers
    }
    @@requests << new_request

    Response.new
  end

  def last_request
    @@requests.last
  end
end
