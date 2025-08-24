defmodule Payfi.Workers.DailyDrawRun do
  use Oban.Worker, queue: :daily_draw_run
  alias Payfi.Draws

  @impl Oban.Worker
  def perform(%Oban.Job{args: _args}) do
    Payfi.Draws.list_draws()
    |> Enum.filter(fn draw ->
      draw.date == Date.utc_today()
    end)
    |> Enum.map(fn draw ->
      _ = Draws.run(draw.id)
    end)

    :ok
  end
end
