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

  test "should contains username and password" do
    url = "postgres://testuser:testpassword@localhost/database"

    parsed_url = parse(url)
    assert Keyword.get(parsed_url, :username) == "testuser"
    assert Keyword.get(parsed_url, :password) == "testpassword"
  end

  test "should contains only username" do
    urls = [
      "postgres://testuser@localhost/database",
      "postgres://testuser:@localhost/database"
    ]

    assert urls
    |> Enum.map(&parse/1)
    |> Enum.all?(
      fn parsed_url ->
        Keyword.get(parsed_url, :username) == "testuser" and not Keyword.has_key?(parsed_url, :password)
      end)
  end

  test "should contains only password" do
    url = "postgres://:testpassword@localhost/database"

    parsed_url = parse(url)
    assert Keyword.get(parsed_url, :password) == "testpassword"
    assert not Keyword.has_key?(parsed_url, :username)
  end

  test "should not contain the username and password" do
    url = "postgres://:@localhost/database"

    parsed_url = parse(url)
    assert not Keyword.has_key?(parsed_url, :username)
    assert not Keyword.has_key?(parsed_url, :password)
  end
end
