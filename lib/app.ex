import Xup

defsupervisor Fwc.Sup, strategy: :one_for_one do
  worker do: [id: Crazybingo.MockingBird]
end

defmodule Fwc.App do
  use Application.Behaviour
  
  def start(_, _) do
    env = Application.environment :fwc 
    {:ok, _} = :cowboy.start_http :http, 100, [port: env[:http_port]], [env: [dispatch: :cowboy_router.compile(env[:http_dispatch])]]
    {:ok, _} = Fwc.Sup.start_link
  end
end

defmodule Crazybingo.MockingBird do
  use GenServer.Behaviour
  import GenX.GenServer

  defrecord State, id: nil

  defcall get_state, from: _from, state: state, do: {:reply, state, state}

  def start_link do
    :gen_server.start_link __MODULE__, nil, []
  end

  def start_link(rid) do
    :gen_server.start_link __MODULE__, rid, []
  end

  def init(rid), do: {:ok, State.new(id: rid)}

end
