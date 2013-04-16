defmodule Fwc.HTTP do
  defmodule Parser do
    def init(_, req, []), do: {:ok, req, :undefined}
    def handle(req, state) do 
      {:ok, req} = :cowboy_req.reply 200, [], "#{inspect req}", req 
      {:ok, req, state}
    end
    def terminate(_, _, _), do: :ok
  end
  defmodule Game do
    def init(_, req, []), do: {:ok, req, :undefined}
    def handle(req, state) do 
      {:ok, req} = :cowboy_req.reply 200, [], "#{inspect req}", req 
      {:ok, req, state}
    end
    def terminate(_, _, _), do: :ok
  end
end
