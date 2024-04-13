FROM elixir:slim

WORKDIR /opt
COPY lib ./lib
COPY mix.exs ./mix.exs

ARG MIX_ENV=dev

RUN mix deps.get --only $MIX_ENV && mix build
