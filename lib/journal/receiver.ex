defmodule Journal.Receiver do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_cast({:push, entry}, state) do
    Journal.Writer.write_today(entry)
    {:noreply, []}
  end

  def push(pid, entry) do
    GenServer.cast(pid, {:push, entry})
  end
end
