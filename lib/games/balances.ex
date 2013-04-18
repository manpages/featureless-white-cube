defmodule Fwc.Balances do
  use GenServer.Behaviour
  import GenX.GenServer

  def init(_) do 
    {:ok, nil}
  end
end
