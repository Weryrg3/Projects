defmodule MainApplication do
  use Application

  def start(_type, args) do

    children = [
      # Sequence2.Stash.start_link(Application.get_env(:sequence2, :initial_number)),
      {SequenceSupervisor, args},
      {StackSupervisor, [1, 2, 4, 3, 5]}
    ]

    opts = [strategy: :rest_for_one, name: MainApplication.Supervisor]
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
