defmodule SteamMiner.HttpParser do

  def get_div_value html do

    {:ok, content: 
    Floki.find(html, "div")
      |> Floki.text
    }
  end
  
end
