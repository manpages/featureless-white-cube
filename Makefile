_src := $(wildcard lib/*.ex) \
	$(wildcard lib/**/*.ex) \
	mix.exs

.PHONY: all clean wipe iex

all: deps ebin sys.config

ebin: $(_src)
	mix compile

deps:
	mix deps.get

sys.config: config.exs lib/config.ex
	@ERL_LIBS=.:deps elixir -e "config = Fwc.Config.file!(%b{config.exs}); config.sys_config!(%b{sys.config})"

iex: all
	@ERL_LIBS=.:deps MIX_ENV=test iex --sname cbingo_console --erl "-config sys -s Elixir-Fwc -boot start_sasl"

clean:
	mix clean

wipe:
	rm -rf ./deps/*
