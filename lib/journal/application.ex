defmodule Journal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, args) do
    children = [
      # Starts a worker by calling: Journal.Worker.start_link(arg)
      # {Journal.Worker, arg}
      %{id: Journal.Receiver, 
        start: {Journal.Receiver, :start_link, [[]]}
       }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Journal.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
