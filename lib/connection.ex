defmodule Connection do
  def start_link(link) do
    EventsourceEx.new(link, stream_to: self())
    get_message()
  end

  def get_message() do
    receive do
      tweet -> Router.router(tweet)
      get_message()
    end
  end

  def child_spec(arg) do
    %{
      id: Connection,
      start: {Connection, :start_link, [arg]}
    }
  end
end
