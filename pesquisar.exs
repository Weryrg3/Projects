defmodule SearchWords do
  def procurar_palavra(word, process) do
    IO.puts("")

    paths = criar_caminho([File.cwd!()], [], process)
    path_by_process = Enum.chunk_every(paths, process)
    IO.puts("")
    pids =
      Enum.map(path_by_process, &spawn(__MODULE__, :procurar_por_arquivo, [&1, word, self()]))

    {:ok, {paths2, arquivos}} = loop([], [], 0, pids)
    # IO.puts("\e[94mPesquisa: \e[1m#{word}\e[0m")
    IO.puts("\e[1mProcessos totais: #{length(pids)}\e[0m")
    IO.puts("\e[1mTotais de arquivos: #{length(paths)}\e[0m")
    IO.puts("\nCriando arquivos.txt com arquivos encontrados")
    IO.puts("\nCriando caminhos.txt com diretórios encontrados")
    Process.sleep(1000)
    File.touch!("arquivos.txt")
    File.touch!("caminhos.txt")
    File.write("arquivos.txt", Enum.join(arquivos, "\n"))
    File.write("caminhos.txt", Enum.join(paths2, "\n"))
  end

  def criar_caminho([], dir, _), do: dir

  def criar_caminho([head | tail], dir, process) do
    if File.dir?(head) do
      pids =
        head
        |> File.ls!()
        |> Enum.chunk_every(process)
        |> Enum.map(&spawn(__MODULE__, :caminhos, [&1, head, self()]))

      novos_arq = loop_caminhos([], pids)

      nova_lista = novos_arq ++ tail
      novo_dir = novos_arq ++ dir
      criar_caminho(nova_lista, novo_dir, process)
    else
      criar_caminho(tail, dir, process)
    end
  end

  def caminhos([], _, pid), do: send(pid, {:fim_caminhos, self()})

  def caminhos([h | tail], head_total, pid) do
    novo_caminho = String.myers_difference(File.cwd!(), head_total)
    send(pid, {:path, "#{novo_caminho[:eq]}#{novo_caminho[:ins]}/#{h}"})
    caminhos(tail, head_total, pid)
  end

  def loop_caminhos(paths, pids) do
    receive do
      {:path, path} ->
        IO.puts(path)
        loop_caminhos([path | paths], pids)

      {:fim_caminhos, pid} ->
        pids = List.delete(pids, pid)

        if pids == [] do
          paths
        else
          Process.exit(pid, :normal)
          loop_caminhos(paths, pids)
        end
    after
      50 ->
        IO.puts("\e[31mErro \e[1m#{inspect(pids)} #{inspect(paths)}\e[0m")
        IO.puts("\e[31m#{String.duplicate("#", 100)}\e[0m")
        paths
    end
  end

  def loop(paths, arquivos, erros, pids) do
    receive do
      {:found, path} ->
        arquivo = List.last(String.split(path, "/"))
        path = Enum.join(List.delete(String.split(path, "/"), arquivo), "/")

        IO.puts("\e[32m #{path}\e[0m \e[1m->\e[0m  \e[94m#{arquivo} \e[0m")
        loop([path | paths], [arquivo | arquivos], erros, pids)

      {:erro, n} ->
        loop(paths, arquivos, erros + n, pids)

      {:fim, pid} ->
        pids = List.delete(pids, pid)

        if pids == [] do
          IO.puts("\nDiretórios: \e[33m #{inspect(paths)} \e[0m\n")
          IO.puts("Arquivos: \e[33m #{inspect(arquivos)} \e[0m")
          IO.puts("\nTamanho lista de arquivos encontrados: \e[95m#{length(paths)}\e[0m")
          IO.puts("Erros encontrados: \e[1m\e[31m#{erros}\e[0m")
          {:ok, {paths, arquivos}}
        else
          Process.exit(pid, :normal)
          loop(paths, arquivos, erros, pids)
        end
    end
  end

  def procurar_por_arquivo([], _word, pid), do: send(pid, {:fim, self()})

  def procurar_por_arquivo([h | t], word, pid) do
    case File.read(h) do
      {:ok, text} ->
        if String.contains?(text, word) do
          send(pid, {:found, h})
        end

        procurar_por_arquivo(t, word, pid)

      {:error, text} ->
        send(pid, {:erro, 1})
        IO.puts("\e[31mErro \e[1m#{Atom.to_string(text)}\e[0m\e[31m #{h}\e[0m")
        procurar_por_arquivo(t, word, pid)
    end
  end
end

SearchWords.procurar_palavra("Agent", 100)
