defmodule SteamMiner.HttpDownloader do

  def api_apps_url do
    "http://api.steampowered.com/ISteamApps/GetAppList/v2"
  end

  def api_headers do
    [
      {  "Accept"         , "json" },
      {  "Connection"     , "keep-alive"}
    ]
  end

  def store_headers do
    [
      { "Accept-Encoding", "utf8"},
      { "Accept-Language", "en-US,en;q=0.8,fr;q=0.6,de:q=0.4"},
      { "User-Agent"     , "Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36"},
      {  "Accept"         , "text/html, application/xhtml+xml,application/xml" },
      {  "Cookie"         , "birthtime=-473389199; lastagecheckage=1-January-1952;" },
      {  "Connection"     , "keep-alive"}
    ]
  end

  def get_http_url(url, headers) do
    case HTTPoison.get(url, store_headers()) do
      {:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 200}}
      -> {:ok, %{body: body, headers: headers}}
      {:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 302}}
      -> {:ok, %{reason: "302 returned."}}
      {:error, %HTTPoison.Error{id: _, reason: reason}} 
      -> {:error, %{reason: reason}}
    end
  end

end
