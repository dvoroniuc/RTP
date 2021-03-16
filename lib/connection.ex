defmodule Connection do
  def start_link(link) do
    link_to = spawn_link(fn -> get_message() end)
    {:ok, _pid} = EventsourceEx.new(link, stream_to: link_to)
  end

  def get_message() do
    receive do
      message -> GenServer.cast(Router, {:router, message})
    end

    get_message()
  end

  def child_spec(arg) do
    %{
      id: Connection,
      start: {Connection, :start_link, [arg]}
    }
  end
end
