defmodule Fwc.HTTP do
  defmodule Balances do
    def init(_, req, []), do: {:ok, req, :undefined}
    def handle(req, state) do 
      Fwc.Sup.add_game Fwc.Balances
      {:ok, req} = :cowboy_req.reply 200, [], "#{inspect req}", req 
      {:ok, req, state}
    end
    def terminate(_, _, _), do: :ok
  end
end
