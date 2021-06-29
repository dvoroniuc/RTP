defmodule Router do
  use GenServer

  def start_link(message) do
    children = [
      Worker.start_link(0),
      Worker.start_link(1),
      Worker.start_link(2),
      Worker.start_link(3),
      Worker.start_link(4),
      Worker.start_link(5)
    ]
    GenServer.start_link(__MODULE__, %{index: 0, children: children}, name: __MODULE__)
  end

  def router(tweet) do
    GenServer.cast(__MODULE__, {:router, tweet.data})
  end

  @impl true
  def init(message) do
    {:ok, message}
  end

  @impl true
  def handle_cast({:router, message}, state) do

    {_, pid} = Enum.at(state.children, rem(state.index, length(state.children)))
    GenServer.cast(pid, {:process, message})

    {:noreply, %{index: state.index + 1 , children: state.children}}
  end
end
