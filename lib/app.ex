import Xup

defsupervisor Fwc.Sup, strategy: :one_for_one do
  def add_game(game_srv) when is_atom(game_srv) do
    {:ok, pid} = :supervisor.start_child Fwc.Sup.Games, [game_srv]
    uuid = :ossp_uuid.make :v4, :text
    Fwc.Ets.Srv.register_game game_srv, uuid, pid
    {:ok, {game_srv, uuid, pid}}
  end
  supervisor Games, strategy: :simple_one_for_one do
    worker do: [id: Fwc.GameStarter]
  end
  worker do: [id: Fwc.Ets.Srv]
end

defmodule Fwc.App do
  use Application.Behaviour
  
  def start(_, _) do
    env = Application.environment :fwc 
    {:ok, _} = :cowboy.start_http :http, 100, [port: env[:http_port]], [env: [dispatch: :cowboy_router.compile(env[:http_dispatch])]]
    {:ok, _} = Fwc.Sup.start_link
  end
end

defmodule Fwc.GameStarter do
  def start_link(game_srv) when is_atom(game_srv) do
    :gen_server.start_link game_srv, nil, []
  end
end
