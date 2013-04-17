defmodule Fwc.Ets do
  def new, do: :ets.new(Games, [:bag, :named_table, {:read_concurrency, true}])
  def register_game(name, uuid, pid) do 
    :ets.insert Games, {name, uuid, pid}
    {:ok, {name, uuid, pid}}
  end
  def get(name) when is_atom(name) do
    :ets.match Games, {name, :'$1', :'$2'}
  end
  def get(name, uuid) when is_atom(name) and is_binary(uuid) do
    :ets.match Games, {name, uuid, :'$1'}
  end
end
