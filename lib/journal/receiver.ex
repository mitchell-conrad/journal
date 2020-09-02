defmodule Journal.Receiver do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call({:push, entry}, _from, state) do
    Journal.Writer.write_today(entry)
    {:reply, [], []}
  end

  def push(pid, entry) do
    GenServer.call(pid, {:push, entry})
  end
end
