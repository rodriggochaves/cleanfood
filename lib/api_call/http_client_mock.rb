class HttpClientMock
  @@requests = []

  def post(url:, params:, headers:)
    new_request = {
      url: url,
      params: params,
      headers: headers
    }
    @@requests << new_request
  end

  def last_request
    @@requests.last
  end
end
