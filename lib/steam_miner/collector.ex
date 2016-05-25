defmodule SteamMiner.Collector do
  use GenServer

  # Client

  @doc """
  Starts new collector.
  """

  def start_link([]) do
    GenServer.start_link(__MODULE__, :ok, name: SteamCollector)
  end

  @doc """
  looks up the bucket
  """
  def get(steam_id) do
    GenServer.call(SteamCollector, {:get, steam_id})
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
  def handle_call({:get, steam_id}, _from, {names, _} = state) do
    {:ok, result} = SteamMiner.HttpDownloader.get_http_url("http://store.steampowered.com/app/" <> steam_id)
    {:ok, %{content: content}} = SteamMiner.HttpParser.get_element_value(result.body,"div", "apphub_AppName")
    IO.puts "Collector Reports: #{result.body}"
    {:reply, [content | result]}
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
