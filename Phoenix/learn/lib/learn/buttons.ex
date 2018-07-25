defmodule Learn.Buttons do
  @moduledoc """
  Controle dos buttons que aparecem no site
  """
  alias Learn.NovosTestes, as: NovosT
  alias Learn.BD
  @random ["primary", "danger", "success", "info", "warning"]

  @doc """
  Função que recebe como param o nome do button a ser alterado,
  retorna uma tupla com nome do button, seu tamanho, button em
  formato de map e a cor.
  """
  def main_button("automatico", nome_button) do
    button_map = get_button(nome_button)
    cor = button_map["cor"]
    # Delete keys do mapa como condição de parada do automatico
    {tamanho, button_map} = delete_keys_map(button_map)
    {nome_button, tamanho, button_map, cor}
  end

  def main_button("clear", nome_button) do
    button_map = change_all_colors("default", nome_button)
    update_button(button_map, nome_button)
    button_map
  end

  def main_button("all", nome_button) do
    cor = get_button(nome_button)["cor"]
    button_map = change_all_colors(cor, nome_button)
    update_button(button_map, nome_button)
    button_map
  end

  def main_button("main_button_default", params, c_params) do
    # Button em formato de string
    button_str = retorna_default_button("Button_Default")
    # Button em formato de mapa
    map = str_to_map(button_str)
    cor_automatica = Enum.random(@random)

    map_tratado = map_main_button(map, params, cor_automatica)

    new_map =
      if c_params == %{"automatico" => "automatico"} do
        Map.update!(map_tratado, "cor", fn _ -> cor_automatica end)
      end

    update_button(new_map || map_tratado, "Button_Default")

    map_tratado
  end

  defp str_to_map(button_str) do
    button_str
    |> String.split("\n")
    |> Enum.map(fn str ->
      str |> String.split("=") |> List.to_tuple()
    end)
    |> Map.new()
  end

  defp delete_keys_map(map) do
    keys =
      Enum.map(map, fn {pos, cor} ->
        if cor != "default" or pos == "cor", do: pos
      end)

    map = Map.drop(map, keys)
    {length(Map.to_list(map)), map}
  end

  defp change_all_colors("random", nome_button) do
    button_map = get_button(nome_button)

    Map.merge(button_map, button_map, fn m, p1, _ ->
      if m == "cor" do
        p1
      else
        Enum.random(@random)
      end
    end)
  end

  defp change_all_colors(cor, nome_button) do
    button_map = get_button(nome_button)

    Map.merge(button_map, button_map, fn m, p1, _ ->
      if m == "cor" do
        p1
      else
        cor
      end
    end)
  end

  defp map_main_button(map, params, cor_automatica) do
    Map.merge(map, params, fn m, p1, p2 ->
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

  # def read_file(arg) do
  #   file_read(arg)
  # end

  ## Implementação de inserção de buttons no BD

  @doc "Retorna um mapa do button"
  def get_button(texto) do
    button_str = retorna_default_button(texto)
    str_to_map(button_str)
  end

  defp update_button(map, texto) do
    str = map_to_str(map)
    # "Button_Default"
    button = BD.get_file_by(NovosT, texto: texto)
    changeset = NovosT.changeset(button, %{buttons2: str})
    BD.update_file(changeset)
  end

  defp map_to_str(button_map) do
    button_map
    |> Map.to_list()
    |> Enum.map(fn {pos, cor} -> "#{pos}=#{cor}" end)
    |> Enum.join("\n")
  end

  # Procura button por param passado caso não encontra cria um novo
  defp retorna_default_button(texto) do
    case BD.get_file_by(NovosT, texto: texto) do
      nil -> cria_novo_button(texto).buttons2
      button -> button.buttons2
    end
  end

  defp cria_novo_button(texto, tam \\ "13x13") do
    # "13x13"
    button = make_button(tam)
    params = %{texto: texto, num: 1, buttons2: button}
    changeset = NovosT.changeset(%NovosT{}, params)
    {:ok, button} = BD.insert_data(changeset)
    button
  end

  # def make_button(tamanho) do
  #   tamanho
  #   |> String.split(["x", "X", "*"])
  #   |> (fn [n1, n2] ->
  #         String.to_integer(n1) * String.to_integer(n2)
  #       end).()
  #   |> (fn n ->
  #         Enum.map(1..n, fn n -> "#{n}=default" end)
  #       end).()
  #   |> (fn string ->
  #         string ++ ["cor=primary"]
  #       end).()
  #   |> Enum.join("\n")
  # end

  def make_button(tamanho) do
    {tam1, tam2} =
      tamanho
      |> String.split(["x", "X", "*"])
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    length_tam = String.length("#{max(tam1, tam2)}")

    list_string =
      for n1 <- 1..tam1,
          n2 <- 1..tam2 do
        pad = String.pad_leading("#{n2}", length_tam, "0")
        "#{n1}.#{pad}=default"
      end

    (["cor=primary"] ++ list_string)
    |> Enum.join("\n")

    # |> IO.inspect(limit: :infinity)
  end
end
