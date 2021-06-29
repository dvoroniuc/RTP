defmodule Worker do
  use GenServer, restart: :transient

  def start_link(message) do
    GenServer.start_link(__MODULE__, :ok, name: {:global, message})
  end

  def process(tweet) do
    GenServer.cast(__MODULE__, {:process, tweet})
  end

  @impl true
  def init(message) do
    {:ok, message}
  end

  @impl true
  def handle_cast({:process, message}, _states) do
    process_message(message)
    {:noreply, %{}}
  end

  def process_message(message) do
    if message =~ "{\"message\": panic}" do
      IO.inspect(%{"Kill message:" => message})
    else
      parsed_data = Poison.decode!(message)
      rate_message(parsed_data["message"]["tweet"])
    end
  end

  def rate_message(message) do
    words =
      message["text"]
      |> String.replace([",", ".", "?", ";",":", "!"], "")
      |> String.split(" ", trim: true)

    scores = Enum.map(words, fn word -> EmotionValues.get_emotion_value(word) end)
    score = Enum.sum(scores)
    IO.puts(score)

  end
end
