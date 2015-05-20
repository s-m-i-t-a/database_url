defmodule DatabaseUrl do

  @adapters %{
    "postgres" => Ecto.Adapters.Postgres,
    "mysql" => Ecto.Adapters.MySQL
  }

  def parse(url) do
    process URI.parse(url)
  end

  defp process(%{
    scheme: scheme,
    host: host,
    path: "/" <> database,
    userinfo: userinfo,
    port: port
  }) do
    [
      host: host,
      database: database,
      adapter: @adapters[scheme]
    ]
    ++ port(port)
    ++ username_and_password(userinfo)
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

end
