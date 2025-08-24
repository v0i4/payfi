defmodule Payfi.HandlersSupervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      {Payfi.Handlers.UserHandler, []},
      {Payfi.Handlers.DrawHandler, []},
      {Payfi.Handlers.ParticipationHandler, []}
    ]

    opts = [strategy: :one_for_one, name: Payfi.HandlersSupervisor]
    Supervisor.init(children, opts)
  end
end
