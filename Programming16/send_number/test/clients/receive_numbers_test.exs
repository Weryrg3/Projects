defmodule Clients.ReceiveNumbersTest do
  alias SendNumber.Clients.ReceiveNumbers
  use ExUnit.Case

  {:ok, pid} = ReceiveNumbers.start_link(12345)
  @pid pid

  test "test1" do
    send(@pid, {:name, "Wesley"})

  end
end
