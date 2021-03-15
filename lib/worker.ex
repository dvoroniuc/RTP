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
    process_message(message)
    {:noreply, %{}}
  end

  def process_message(message) do
    if message.data =~ "{\"message\": panic}" do
      IO.inspect(%{"Kill message:" => message.data})
      Process.exit(self(), :kill)
    else
      parsed_data = Poison.decode!(message.data)
      rate_message(parsed_data["message"]["tweet"])
    end
  end

  def rate_message(message) do
    words =
      message["text"]
      |> String.split(" ", trim: true)

    scores = Enum.map(words, fn word -> EmotionValues.get_emotion_value(word) end)
    score = Enum.sum(scores)

    IO.puts(score)
  end
end
