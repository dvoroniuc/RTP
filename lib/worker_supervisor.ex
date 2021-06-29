defmodule WorkerSupervisor do
  use DynamicSupervisor

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def spawn_worker(message) do
    spec = {Worker, {message}}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def kill_worker(worker_pid) do
    DynamicSupervisor.terminate_child(__MODULE__, worker_pid)
  end
end
