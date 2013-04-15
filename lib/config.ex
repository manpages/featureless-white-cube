defmodule Fwc.Config do
  use ExConfig.Object

  defproperty http_port, default: 55556
  defproperty games_dispatch, default: {"/game", Fwc.Game, []}

  def sys_config(config) do
    [
      fwc: [ http_port: config.http_port,

      http_dispatch: [{:_, [
        {"/static/[...]", :cowboy_static, [
          directory: ["priv","static"],
          mimetypes: [
            {".txt", ["text/plain"]},
            {".css", ["text/css"]},
            {".js", ["application/javascript"]},
            {".png", ["image/png"]},
            {".jpg", ["image/jpeg"]},
            {".log", ["text/plain"]},
          ]
        ]}
      ] ++ config.games_dispatch}], ]
    ]
  end

  def sys_config!(filename, config) do
    File.write! filename, :io_lib.format("~p.~n", [sys_config(config)])
  end
end
