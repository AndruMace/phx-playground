defmodule NewWeb.WrongLive do
  use NewWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time(), answer: Enum.random(1..10))}
  end

  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your Score: {@score}</h1>
    <h2>
      {@message}
      <br/>
      It's {@time}
    </h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700 text-white
          font-bold py-2 px-4 bordewr-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}>

          {n}
        </.link>
      <% end %>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score, answer} =
      if guess == (socket.assigns.answer |> to_string) do
        {"Correct! Great job", socket.assigns.score + 1, Enum.random(1..10)}
      else
        {"Incorrect", socket.assigns.score - 1, socket.assigns.answer}
      end

    IO.inspect(socket.assigns.answer, label: "Answer")
    IO.inspect(guess, label: "Guess")

    time = time()
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time,
        answer: answer
      )
    }
  end
end
