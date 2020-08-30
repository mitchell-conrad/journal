defmodule Journal.Tracker do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end


  def init(:ok) do
    {:ok, socket} = :gen_udp.open(14567, [
      :binary,
      broadcast: true,
      active: true,
      ip: {0,0,0,0}
    ])


    :ok = :gen_udp.send(socket, {100, 255, 255, 255}, 14567, "ADD ME")

    {:ok, MapSet.new}

  end

  def hello(other) do
    GenServer.call(__MODULE__, {:hello, other})
  end

  def current() do
    GenServer.call(__MODULE__, :current)
  end

  def handle_call({:hello, other}, _from, nodes) do
    :erlang.monitor_node(other, true)
    nodes = MapSet.put(nodes, other)
    GenEvent.notify(Journal.Broadcast, {:nodes, MapSet.put(nodes, node())})
    {:reply, :ok, nodes}
  end

  def handle_info({:nodedown, other}, nodes) do
    nodes = MapSet.delete(nodes, other)
    GenEvent.notify(Journal.Broadcast, {:nodes, MapSet.put(nodes, node())})
    {:noreply, nodes}
  end

  def handle_info({:udp, _socket, ip, 14567, "ADD ME"}, nodes) do
    {a, b, c, d} = ip
    other = :"node@#{a}#{b}#{c}#{d}"
    if other != node do
      :ok = :rpc.call(other, __MODULE__, :hello, [node])
      :erlang.monitor_node(other, true)
      nodes = MapSet.put(nodes, other)
      GenEvent.notify(Journal.Broadcast, {:nodes, MapSet.put(nodes, node())})
    end
    {:noreply, nodes}
  end
end
