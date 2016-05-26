defmodule SteamMiner do

  use Application 

  defp pool_name() do
    :steam_miner_pool
  end

  def start(_type, _args) do
    poolboy_config = [
      {:name, {:local, pool_name()}},
      {:worker_module, SteamMiner.Collector},
      {:size, 5512},
      {:max_overflow, 5256}
    ]

    children = [
      :poolboy.child_spec(pool_name(), poolboy_config, [])
    ]

    options = [
      strategy: :one_for_one,
      name: SteamMiner.Supervisor
    ]

    Supervisor.start_link(children, options)

  end

  def basic_pool(steam_id) do
    pool_steam_mine(steam_id)    
  end
  
  def parallel_pool(range) do
    Enum.each(
      range, 
      fn(steam_id) -> spawn ( fn() -> pool_steam_mine(steam_id) end ) end 
    )
  end

  defp pool_steam_mine(steam_id) do
    :poolboy.transaction(
    pool_name(),
    fn(pid) -> SteamMiner.Collector.get(pid, steam_id) end, 
    :infinity
    )

  end
end
