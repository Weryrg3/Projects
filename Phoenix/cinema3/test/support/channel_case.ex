defmodule Cinema3.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  alias Cinema3.Repo
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      # Import conveniences for testing with channels
      use Phoenix.ChannelTest

      alias Cinema3.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      # The default endpoint for testing
      @endpoint Cinema3.Endpoint
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async] do
      Sandbox.mode(Cinema3.Repo, {:shared, self()})
    end

    :ok
  end
end
