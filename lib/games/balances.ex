defmodule Fwc.Balances do
  use GenServer.Behaviour
  import GenX.GenServer

  def init(input) do 
    IO.puts "#{__MODULE__}:init(#{inspect input})"
    {:ok, nil}
  end
end
