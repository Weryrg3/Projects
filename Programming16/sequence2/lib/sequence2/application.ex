defmodule Sequence2.Application do

  use Application

  def start(_type, _args) do
    children = [
      {Sequence2.Stash, 123},
      {Sequence2.Server, nil},
      {Stack.Stash, [122]},
      {Stack.Server, [nil]}
    ]

    opts = [strategy: :rest_for_one, name: Sequence2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# strategy: :one_for_one
# :one_for_one  Padrão, irá só reiniciar o processor que parou  p.255
# :one_for_all  Irá reiniciar todos processos p.255
# :rest_for_one Irá reiniciar só processos seguidos pela ordem colocado  p.256
# use GenServer, restart: :trasient
# :permanent  Sempre irá reiniciar p.258
# :temporary  Nunca irá reiniciar p.258
# :transient  Irá reiniciar apenas se travar p.259
