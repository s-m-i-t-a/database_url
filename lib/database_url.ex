defmodule DatabaseUrl do

  @adapters %{
    "postgres" => Ecto.Adapters.Postgres,
    "mysql" => Ecto.Adapters.MySQL
  }

  @filters %{
    "size" => &String.to_integer/1,
    "ssl" => &String.to_existing_atom/1,
    "timeout" => &String.to_integer/1,
    "lazy" => &String.to_existing_atom/1,
    "max_overflow" => &String.to_integer/1,
    "connect_timeout" => &String.to_integer/1,
    "log_level" => &String.to_atom/1,
  }

  def parse(url) do
    process URI.parse(url)
  end

  defp process(%{
    scheme: scheme,
    host: host,
    path: "/" <> database,
    userinfo: userinfo,
    port: port,
    query: query
  }) do
    [
      host: host,
      database: database,
      adapter: @adapters[scheme]
    ]
    ++ port(port)
    ++ username_and_password(userinfo)
    ++ process_query(query)
  end

  defp port(nil), do: []
  defp port(port) do
    [port: port]
  end

  defp username_and_password(nil), do: []
  defp username_and_password(userinfo) do
    case String.split(userinfo, ":") do
      [username] ->
        [username: username]
      ["", ""] ->
        []
      ["", password] ->
        [password: password]
      [username, ""] ->
        [username: username]
      [username, password] ->
        [username: username, password: password]
    end
  end

  defp process_query(nil), do: []
  defp process_query(query) do
    URI.query_decoder(query)
    |> Enum.map(fn {key, value} -> {String.to_atom(key), Map.get(@filters, key, &(&1)).(value)} end)
  end
end
