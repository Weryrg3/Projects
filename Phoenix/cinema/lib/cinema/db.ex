defmodule Cinema.DB do
  alias Cinema.{Repo, User, Video}

  def insert_in_db_user(user_params) do
    User.registrar_changeset(%User{}, user_params)
    |> Repo.insert()
  end

  def update_in_db_user(user_params, id) do
    Repo.get!(User, id)
    |> User.registrar_changeset(user_params)
    |> Repo.update()
  end

  def delete_in_db_user(id) do
    Repo.get!(User, id)
    |> Repo.delete!()
  end

  def insert_in_db_video(video_params) do
    Video.changeset(%Video{}, video_params)
    |> Repo.insert()
  end

  def update_in_db_video(video_params) do
    Video.changeset(%Video{}, video_params)
    |> Repo.update()
  end

  def delete_in_db_video(id) do
    Repo.get!(Video, id)
    |> Repo.delete!()
  end
end
