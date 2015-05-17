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
    port: port
  }) do
    [
      host: host,
      database: database,
      adapter: @adapters[scheme]
    ]
    ++ port(port)
  end

  defp port(nil), do: []
  defp port(port) do
    [port: port]
  end

end
