defmodule SteamMinerTest do
  use ExUnit.Case
  doctest SteamMiner

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "HttpDownloader get a simple valid request to Phobos Project" do
    assert {:ok, _} = SteamMiner.HttpDownloader.get_http_url("http://www.phobosproject.com") 
  end

  test "Http downloader get an invalid url results in an error" do
    assert {:error, _} = SteamMiner.HttpDownloader.get_http_url("http://doesnotexiststhisshit.com")
  end

  test "Get div content of HTML document" do
    assert {:ok, content: "This is a div."} = SteamMiner.HttpParser.get_div_value("<html><div>This is a div.</div></html>")
  end

end
