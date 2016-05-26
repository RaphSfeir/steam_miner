defmodule SteamMiner.Collector do
  use GenServer

  # Client

  @doc """
  Starts new collector.
  """

  def start_link([]) do
    :gen_server.start_link(__MODULE__, :ok, [])
  end

  @doc """
  looks up the bucket
  """
  def get(pid, steam_id) do
    :gen_server.call(pid, {:get, steam_id})
  end

  @doc """

  """
  def post(steam_id) do
    GenServer.cast(SteamCollector, {:post, "454690"})
  end

  #Server callbacks

  @doc """

  """
  def init(state) do
    {:ok, state}
  end

  @doc """
  Get the names
  """
  def handle_call({:get, steam_id}, from, state) do
    IO.puts "Receiving Call Steam #{steam_id}"
    {:ok, result} = SteamMiner.HttpDownloader.get_http_url("http://store.steampowered.com/app/" <> Integer.to_string(steam_id), SteamMiner.HttpDownloader.store_headers())
    {:ok, %{content: content}} = SteamMiner.HttpParser.get_element_value(result.body,"div", "apphub_AppName")
    IO.puts "Collector Reports: #{content}"
    {:reply, [content], state}
  end
  
  @doc """
  Post to Steam Miner
  """

  def handle_cast({:post, steam_id}, state) do
    alias SteamMiner.HttpDownloader
    alias SteamMiner.HttpParser
    {:ok, result} = HttpDownloader.get_http_url("http://store.steampowered.com/app/" <> steam_id)
    {:ok, %{content: content}} = HttpParser.get_element_value(result.body,"div", "apphub_AppName")
    {:noreply, [content | result]}
  end
end
