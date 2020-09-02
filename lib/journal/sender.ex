defmodule Journal.Sender do

  def send(entry) do
    GenServer.abcast(Journal.Receiver, {:push, entry})
  end
end
