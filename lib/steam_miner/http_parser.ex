defmodule SteamMiner.HttpParser do

  def get_div_value html, div_class do
    find_res = Floki.find(html, "div." <> div_class)

    case find_res do 
      [] 
        -> {:error, %{reason: "Not found"}}
      [_] 
        -> 
          {:ok, %{content: find_res |> Floki.text }}
    end
  end
  
end
