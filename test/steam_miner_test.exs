defmodule SteamMinerTest do
  use ExUnit.Case
  doctest SteamMiner

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Simple HTTPoison request to Phobos Project" do
    assert {:ok, _} = SteamMiner.HttpDownloader.get_http_url("http://www.phobosproject.com") 
  end

  test "Parse some HTML Document" do
    
  end

end
