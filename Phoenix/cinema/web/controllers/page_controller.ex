defmodule Cinema.PageController do
  use Cinema.Web, :controller
  alias Cinema.Video

  def index(conn, _params) do
    videos = Repo.all(Video)
    render(conn, "index.html", videos: videos)
  end
end
