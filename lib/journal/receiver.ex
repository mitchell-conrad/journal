defmodule Journal.Receiver do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init() do
    {:ok, []}
  end

  def handle_cast({:push, entry}, state) do
    Journal.write_today(entry)
    {:noreply, state}
  end

  def push(pid, entry) do
    GenServer.cast(pid, {:push, entry})
  end
end
