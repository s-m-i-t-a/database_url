defmodule DatabaseUrl do

  import URI

  @adapters %{
    "postgres" => Ecto.Adapters.Postgres,
    "mysql" => Ecto.Adapters.MySQL
  }

  def parse(url) do
    process URI.parse(url)
  end

  defp process(%{scheme: scheme, host: host, path: "/" <> database}) do
    [
      host: host,
      database: database,
      adapter: @adapters[scheme]
    ]
  end
end
