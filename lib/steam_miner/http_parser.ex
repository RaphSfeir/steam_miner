defmodule SteamMiner.HttpParser do

  def get_element_value html, element, class do
    find_res = Floki.find(html, element <> "." <> class)

    case find_res do 
        [] 
        ->
        {:error, %{reason: "Not found"}}
        [h | _] 
        -> 
        {:ok, %{content: h |> Floki.text }}
        _ -> 
        {:error, find_res}
    end
  end

end
