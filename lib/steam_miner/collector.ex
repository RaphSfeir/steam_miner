defmodule SteamMiner.Collector do
  @doc """
  Starts new collector.
  """
  
  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets value from bucket
  """
  def get(collector, key) do
    Agent.get(collector, &Map.get(&1, key))
  end

  @doc """
  Put value 
  """

  def put(collector, key, value) do
    Agent.update(collector, &Map.put(&1, key, value))
  end
end
