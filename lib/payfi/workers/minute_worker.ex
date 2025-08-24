defmodule Payfi.Workers.MinuteWorker do
  use Oban.Worker, queue: :daily_draw_run

  @impl Oban.Worker
  def perform(%Oban.Job{args: _args}) do
    IO.inspect("#################################### HELLO FROM OBAN - MINUTE WORKER")

    :ok
  end
end
