require "net/http"

class GenericHttpClient
  def get(url)
    Net::HTTP.get_response(URI(url))
  end
end
