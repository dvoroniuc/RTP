defmodule Worker do
  use GenServer, restart: :transient

  def start_link(message) do
    GenServer.start(__MODULE__, message, name: __MODULE__)
  end

  @impl true
  def init(message) do
    {:ok, message}
  end

  @impl true
  def handle_cast({:worker, message}, _states) do
    IO.inspect(%{"message:" => message})
    {:noreply, %{}}
  end
end
