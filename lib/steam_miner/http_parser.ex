defmodule SteamMiner.HttpParser do

  def get_element_value html, element, class do
    find_res = Floki.find(html, element <> "." <> class)

    case find_res do 
    [] 
      ->
        {:error, %{reason: "Not found"}}
        [_] 
        -> 
        {:ok, %{content: find_res |> Floki.text }}
        _ -> 
        {:error, find_res}
    end
  end

end
