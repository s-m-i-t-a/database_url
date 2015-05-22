# DatabaseUrl

[![Build Status](https://semaphoreci.com/api/v1/projects/91fb642e-351c-40c4-a0d4-7c45e4e0f7bf/431905/badge.svg)](https://semaphoreci.com/smita/database_url)
[![Coverage Status](https://coveralls.io/repos/s-m-i-t-a/database_url/badge.svg?branch=master)](https://coveralls.io/r/s-m-i-t-a/database_url?branch=master)

Parse database URL and renturn keyword list for use with Ecto.


## Installation

```elixir
defp deps do
  [ {:database_url, "~> 0.1"}, ]
end
```


## Usage

### API

```elixir
    iex> url = "postgres://localhost/database?size=30&ssl=true&encoding=utf-8"
    iex> options = DatabaseUrl.parse(url)
    [host: "localhost", database: "database", adapter: Ecto.Adapters.Postgres,
    size: 30, ssl: true, encoding: "utf-8"]
```


### Use with Phoenix + Ecto

Use in project config and assume `DATABASE_URL` environment variable is set.

```elixir
# Configure your database
config :myapp, MyApp.Repo, DatabaseUrl.parse(System.get_env("DATABASE_URL"))
```
