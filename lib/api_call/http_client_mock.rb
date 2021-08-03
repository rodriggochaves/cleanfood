class HttpClientMock
  @@requests = []
  @@responses = []

  def post(url:, params:, headers:)
    new_request = {
      url: url,
      params: params,
      headers: headers
    }
    @@requests << new_request

    @@responses.pop
  end

  def last_request
    @@requests.last
  end

  def mock_responses(response:)
    @@responses << response
  end
end
