#!/bin/zsh
mix ecto.drop
MIX_ENV=test mix ecto.drop
mix ecto.create
MIX_ENV=test mix ecto.create
mix ecto.migrate
MIX_ENV=test mix ecto.migrate
