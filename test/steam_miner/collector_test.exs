defmodule SteamMiner.CollectorTest do
  use ExUnit.Case, async: true

  setup do 
    {:ok, collector} = SteamMiner.Collector.start_link
    {:ok, collector: collector}
  end

  test "Store HTML with app Id", %{collector: collector} do
    assert SteamMiner.Collector.get(collector) == nil

    SteamMiner.Collector.put(collector, "test", 14)
    assert SteamMiner.Collector.get(collector) == 14
  end

end
