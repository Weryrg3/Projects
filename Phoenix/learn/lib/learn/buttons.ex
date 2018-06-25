defmodule Learn.Buttons do
  @random ["primary", "danger", "success", "info", "warning"]

  def main_button("automatico", name_request) do
    [_, arg, _] = String.split(name_request, "/")

    {tamanho, map} = delete_keys_map(file_read(arg))

    cor = file_read(arg)["cor"]

    {arg, tamanho, map, cor}
  end

  def main_button("clear", name_request) do
    [_, arg, _] = String.split(name_request, "/")
    pos = pos("default", arg)
    file_write(pos, arg)
    pos
  end

  def main_button("all", name_request) do
    [_, arg, _] = String.split(name_request, "/")
    pos = pos(file_read(arg)["cor"], arg)
    file_write(pos, arg)
    pos
  end

  def main_button("default", name_request, params, cparams) do
    [_, arg, _] = String.split(name_request, "/")

    file = file_read(arg)
    cor_automatica = Enum.random(@random)

    map =
      Map.merge(file, params, fn m, p1, p2 ->
        case p1 do
          "default" ->
            if p2 == "random" do
              cor_automatica
            else
              p2
            end

          _ ->
            cond do
              m == "cor" and p1 == "random" ->
                "primary"

              m == "cor" and p1 != "random" ->
                p2

              true ->
                "default"
            end
        end
      end)

    new_map =
      if cparams == %{"automatico" => "automatico"} do
        Map.update!(map, "cor", fn _ -> cor_automatica end)
      end

    file_write(new_map || map, arg)

    map
  end

  def read_file(arg) do
    file_read(arg)
  end

  defp file_read(arg) do
    "#{File.cwd!()}/lib/learn/#{arg}.txt"
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn str ->
      String.split(str, "=") |> List.to_tuple()
    end)
    |> Map.new()
  end

  defp file_write(map, arg) do
    str =
      Map.to_list(map)
      |> Enum.map(fn {pos, cor} -> "#{pos}=#{cor}" end)
      |> Enum.join("\n")

    File.write!("#{File.cwd!()}/lib/learn/#{arg}.txt", str)
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
