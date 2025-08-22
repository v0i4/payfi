defmodule Payfi.Handlers.DrawHandler do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def create_draw(params) do
    GenServer.call(__MODULE__, {:create_draw, params})
  end

  def handle_call({:create_draw, params}, _from, state) do
    with {:ok, draw} <- Payfi.Draws.create_draw(params) do
      {:reply, {:ok, draw}, state}
    else
      e -> IO.inspect(e)
      _ -> {:reply, {:error, "Error creating draw"}, state}
    end
  end
end
