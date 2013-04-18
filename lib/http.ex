defmodule Fwc.HTTP do
  defmodule Balances do
    def init(_, req, []) do
      {path, req} = :cowboy_req.path req
      {:ok, req, path}
    end
    def handle(req, "/balances/") do 
      {:ok, {Fwc.Balances, uuid, pid}} = Fwc.Sup.add_game Fwc.Balances
      {:ok, req} = :cowboy_req.reply 302, [{"Location", <<"/balances/", uuid :: binary>>}], "", req 
      {:ok, req, "/balances/"}
    end
    def handle(req, state) do
      {:ok, req} = :cowboy_req.reply 200, [], "THE GAME.", req
      {:ok, req, state}
    end
    def terminate(_, _, _), do: :ok
  end
end
