defmodule RTP.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      %{
        id: Router,
        start: {Router, :start_link, [""]}
      },
      %{
        id: Connection1,
        start: {Connection, :start_link, ["localhost:4000/tweets/1"]}
      },
      %{
        id: Connection2,
        start: {Connection, :start_link, ["localhost:4000/tweets/2"]}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RTP.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
