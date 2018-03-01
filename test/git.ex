defmodule Test.Git do
  alias Mix.Shell.IO, as: Shell
  def run() do
    Shell.info("Rodando git")
    Shell.cmd("git init")
    Shell.cmd("git add .")
    Shell.cmd("git ")
  end
end
