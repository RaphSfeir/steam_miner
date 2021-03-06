defmodule SteamMinerTest do
  use ExUnit.Case, async: true
  doctest SteamMiner

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "HttpDownloader get a simple valid request to Phobos Project" do
    assert {:ok, _} = SteamMiner.HttpDownloader.get_http_url("http://www.phobosproject.com", SteamMiner.HttpDownloader.store_headers()) 
  end

  test "Http downloader get an invalid url results in an error" do
    assert {:error, _} = SteamMiner.HttpDownloader.get_http_url("http://doesnotexiststhisshit.com", SteamMiner.HttpDownloader.store_headers())
  end

  test "Get div content of HTML document" do
    assert {:ok, %{content: "This is a div."}} = SteamMiner.HttpParser.get_element_value("<html><div class='test'>This is a div.</div><div class='test2'>This too!</div></html>", "div", "test")
  end

  test "Fetch remote HTML document, parse it and get specific value" do
    {:ok, result} = SteamMiner.HttpDownloader.get_http_url("http://www.phobosproject.com", SteamMiner.HttpDownloader.store_headers())
    assert {:ok, %{content: "Colons\n747En ligne\n0"}} = SteamMiner.HttpParser.get_element_value(result.body,"div", "online_registered")
  end

  test "Steam Store get Cyber City 2157 page with 200 status" do
    assert {:ok, result} = SteamMiner.HttpDownloader.get_http_url("http://store.steampowered.com/app/454690", SteamMiner.HttpDownloader.store_headers())
    assert {:ok, %{content: "Cyber City 2157: The Visual Novel"}} = SteamMiner.HttpParser.get_element_value(result.body,"div", "apphub_AppName")
    assert {:ok, %{content: "Very Positive"}} = SteamMiner.HttpParser.get_element_value(result.body,"span", "game_review_summary")
  end

  test "Steam API get all apps." do
    assert {:ok, apps} = SteamMiner.HttpDownloader.get_http_url(SteamMiner.HttpDownloader.api_apps_url(), SteamMiner.HttpDownloader.api_headers())
    assert {:ok, %{"applist" => _}} = Poison.decode(apps.body)
  end

end
