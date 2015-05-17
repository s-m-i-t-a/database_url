defmodule DatabaseUrlTest do
  use ExUnit.Case

  import DatabaseUrl, only: [parse: 1]

  test "should return database connection options as keywords list" do
    url = "postgres://localhost/database"
    assert Keyword.keyword? parse(url)
  end

  test "should contains host" do
    url = "postgres://localhost/database"
    assert Keyword.get(parse(url), :host) == "localhost"
  end

  test "should contains database name" do
    url = "postgres://localhost/database"
    assert Keyword.get(parse(url), :database) == "database"
  end

  test "should contains adapter" do
    urls = [
      {"postgres://localhost/database", Ecto.Adapters.Postgres},
      {"mysql://localhost/database", Ecto.Adapters.MySQL}
    ]

    assert urls
    |> Enum.all?(fn {url, adapter} -> Keyword.get(parse(url), :adapter) == adapter end)
  end

  test "should contain port if is present" do
    url = "postgres://localhost:1234/database"

    assert Keyword.get(parse(url), :port) == 1234
  end

end
