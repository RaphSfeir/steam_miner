defmodule SteamMiner.HttpDownloader do

  def get_http_url(url) do
    case HTTPoison.get! url do
      %HTTPoison.Response{status_code: 200, body: body, headers: headers}
      -> {:ok, body: body, headers: headers}
      _ 
      -> {:err, result: HTTPoison.get! url}
    end
  end

end
