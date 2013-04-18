defmodule Fwc.Mixfile do
  use Mix.Project

  def project do
    [ app: :fwc,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [
        :crypto, :ranch, :cowboy, :exconfig, :ossp_uuid
      ] ++ env_applications(Mix.env),
      mod: {Fwc.App, []} ]
  end

  def env_applications(:dev), do: [:exreloader]
  def env_applications(_), do: [] 

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:cowboy, github: "extend/cowboy"},
        {:ranch, github: "extend/ranch"},
      {:exconfig, github: "yrashk/exconfig"},
      {:xup, github: "yrashk/xup"},
      {:exreloader, github: "yrashk/exreloader"},
      {:ossp_uuid, github: "yrashk/erlang-ossp-uuid"},
    ]
  end
end
