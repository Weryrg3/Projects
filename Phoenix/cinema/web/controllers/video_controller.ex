defmodule Cinema.VideoController do
  use Cinema.Web, :controller
  alias Cinema.{Video, Categoria, Classificacao, DB}

  plug(:autenticar_manager when action in [:new, :edit, :update, :delete, :create])
  plug(:scrub_params, "video" when action in [:create, :update])
  plug(:load_categorias when action in [:new, :create, :edit, :update])
  plug(:load_classificacoes when action in [:new, :create, :edit, :update])

  def index(conn, _params) do
    videos = Repo.all(Video)
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Video.changeset(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Video.changeset(%Video{}, video_params)

    case Repo.insert(changeset) do
      {:ok, _video} ->
        conn
        |> put_flash(:info, "Filme postado com sucesso.")
        |> redirect(to: video_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    changeset = Video.changeset(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Repo.get!(Video, id)
    changeset = Video.changeset(video, video_params)

    case Repo.update(changeset) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Filme alterado com sucesso.")
        |> redirect(to: video_path(conn, :show, video))

      {:error, changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(video)

    conn
    |> put_flash(:info, "Filme deletado.")
    |> redirect(to: video_path(conn, :index))
  end

  defp load_categorias(conn, _) do
    query =
      Categoria
      |> Categoria.alfabeto()
      |> Categoria.nomes_e_ids()

    categorias = Repo.all(query)
    assign(conn, :categorias, categorias)
  end

  defp load_classificacoes(conn, _) do
    query =
      Classificacao
      |> Classificacao.ordenar()
      |> Classificacao.nomes_e_ids()

    classificacao = Repo.all(query)
    assign(conn, :classificacao, classificacao)
  end
end
