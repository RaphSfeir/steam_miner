defmodule SteamMiner.HttpDownloader do

  def get_http_url(url) do
    case HTTPoison.get url do
      {:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 200}}
      -> {:ok, body: body, headers: headers}
      {:error, %HTTPoison.Error{id: _, reason: reason}} 
      -> {:error, reason: reason}
    end
  end

end
