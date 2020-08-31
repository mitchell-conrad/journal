defmodule Journal.Broadcast do
  use GenEvent

  def start_link(options) do
    GenEvent.start_link(options)
  end

  def child_spec(opts) do
   %{
     id: __MODULE__,
     start: {__MODULE__, :start_link, [opts]},
     type: :worker,
     restart: :permanent,
     shutdown: 500
    }
  end

  def handle_event({:nodes, nodes}, connection) do
    send(connection, {:nodes, nodes})
    {:ok, connection}
  end
end
