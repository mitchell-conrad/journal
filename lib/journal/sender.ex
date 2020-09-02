defmodule Journal.Sender do

  def send(entry) do
    GenServer.multi_call(Journal.Receiver, {:push, entry})
  end
end
