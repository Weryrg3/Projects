defmodule Learn.FormController do
  use Learn.Web, :controller
  alias Learn.Thing

  # form_path GET /form :index
  def index(conn, _params) do
    all = Repo.all(Thing)
    render(conn, "index.html", all: all)
  end

  # form_path GET /form/new :new
  def new(conn, _params) do
    changeset = Thing.changeset(%Thing{})
    render(conn, "new.html", changeset: changeset)
  end

  # form_path GET /form/testes :testes
  def testes(conn, _params) do
    changeset = Thing.changeset(%Thing{})
    render(conn, "testes.html", changeset: changeset)
  end

  # form_path POST /form :create
  def create(conn, %{"thing" => user_params}) do
    changeset = Thing.changeset(%Thing{}, user_params)

    case Repo.insert(changeset) do
      {:ok, thing} ->
        conn
        |> put_flash(:info, "#{thing.name} foi criado")
        |> redirect(to: form_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # form_path GET /form/:id :show
  def show(conn, %{"id" => id}) do
    thing = Repo.get!(Thing, id)
    render(conn, "show.html", thing: thing)
  end

  def edit(conn, %{"id" => id}) do
    thing = Repo.get!(Thing, id)
    changeset = Thing.changeset(thing)
    render(conn, "edit.html", thing: thing, changeset: changeset)
  end

  # form_path PUT /form/:id :update
  def update(conn, %{"id" => id, "thing" => params}) do
    thing = Repo.get!(Thing, id)
    changeset = Thing.changeset(thing, params)

    if changeset.changes == %{} do
      conn
      |> put_flash(:error, "Sem alterações!!")
      |> render("edit.html", thing: thing, changeset: changeset)
    end

    case Repo.update(changeset) do
      {:ok, thing} ->
        conn
        |> put_flash(:info, "Novo thing atualizado com sucesso!!")
        |> redirect(to: form_path(conn, :show, thing))

      {:error, changeset} ->
        render(conn, "edit.html", thing: thing, changeset: changeset)
    end
  end

  def teste(conn, params) do
    conn
    |> put_flash(:info, inspect(params))
  end

  # form_path DELETE /form/:id :delete
  def delete(conn, %{"id" => id}) do
    thing = Repo.get!(Thing, id)
    Repo.delete!(thing)

    conn
    |> put_flash(:info, "#{thing.name} foi excluída com sucesso!!")
    |> redirect(to: form_path(conn, :index))
  end

  # form_path GET /form/submit :submit
  def submit(conn, _) do
    thing = Repo.get!(Thing, 8)
    changeset = Thing.changeset(thing)
    render(conn, "submit.html", thing: thing, changeset: changeset)
  end
end

