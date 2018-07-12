defmodule Learn.Buttons do
  @moduledoc """
  Controle dos buttons que aparecem no site
  """
  @random ["primary", "danger", "success", "info", "warning"]

  def name_request(request) do
    [_, arg, _] = String.split(request, "/")
    arg
  end

  def main_button("automatico", arg) do
    {tamanho, map} = delete_keys_map(file_read(arg))

    cor = file_read(arg)["cor"]

    {arg, tamanho, map, cor}
  end

  def main_button("clear", arg) do
    pos = pos("default", arg)
    file_write(pos, arg)
    pos
  end

  def main_button("all", arg) do
    pos = pos(file_read(arg)["cor"], arg)
    file_write(pos, arg)
    pos
  end

  def main_button("default", arg, params, cparams) do
    file = file_read(arg)
    cor_automatica = Enum.random(@random)

    map = map_main_button(file, params, cor_automatica)

    new_map =
      if cparams == %{"automatico" => "automatico"} do
        Map.update!(map, "cor", fn _ -> cor_automatica end)
      end

    file_write(new_map || map, arg)

    map
  end

  defp map_main_button(file, params, cor_automatica) do
    Map.merge(file, params, fn m, p1, p2 ->
      case p1 do
        "default" ->
          map_main_button_default(p2, cor_automatica)

        _ ->
          map_main_button_not_default(m, p1, p2)
      end
    end)
  end

  defp map_main_button_default(p2, cor_automatica) do
    if p2 == "random" do
      cor_automatica
    else
      p2
    end
  end

  defp map_main_button_not_default(m, p1, p2) do
    cond do
      m == "cor" and p1 == "random" ->
        "primary"

      m == "cor" and p1 != "random" ->
        p2

      true ->
        "default"
    end
  end

  def read_file(arg) do
    file_read(arg)
  end

  defp file_read(arg) do
    "#{File.cwd!()}/lib/learn/buttons_txt/#{arg}.txt"
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn str ->
      str |> String.split("=") |> List.to_tuple()
    end)
    |> Map.new()
  end

  defp file_write(map, arg) do
    str =
      map
      |> Map.to_list()
      |> Enum.map(fn {pos, cor} -> "#{pos}=#{cor}" end)
      |> Enum.join("\n")

    File.write!("#{File.cwd!()}/lib/learn/buttons_txt/#{arg}.txt", str)
  end

  defp pos("random", arg) do
    file = file_read(arg)

    Map.merge(file, file, fn m, p1, _ ->
      if m == "cor" do
        p1
      else
        Enum.random(@random)
      end
    end)
  end

  defp pos(cor, arg) do
    file = file_read(arg)

    Map.merge(file, file, fn m, p1, _ ->
      if m == "cor" do
        p1
      else
        cor
      end
    end)
  end

  defp delete_keys_map(map) do
    keys =
      Enum.map(map, fn {pos, cor} ->
        if cor != "default" or pos == "cor", do: pos
      end)

    map = Map.drop(map, keys)
    {length(Map.to_list(map)), map}
  end
end
