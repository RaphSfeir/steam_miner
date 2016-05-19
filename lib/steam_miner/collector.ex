defmodule SteamMiner.Collector do
  use GenServer

  # Client

  @doc """
  Starts new collector.
  """

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: SteamCollector)
  end

  @doc """
  looks up the bucket
  """
  def get(name) do
    GenServer.call(SteamCollector, {:get})
  end

  @doc """

  """
  def post(steam_id) do
    GenServer.cast(SteamCollector, {:post, "454690"})
  end

  #Server callbacks

  @doc """

  """
  def init(:ok) do
    result = %{}
    {:ok, %{result}}
  end

  @doc """
  Get the names
  """
  def handle_call({:get}, _from, {names, _} = state) do

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
