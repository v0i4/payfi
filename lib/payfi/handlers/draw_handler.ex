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

  def get_result(draw_id) do
    GenServer.call(__MODULE__, {:get_result, draw_id})
  end

  def handle_call({:create_draw, params}, _from, state) do
    with {:ok, draw} <- Payfi.Draws.create_draw(params) do
      {:reply, {:ok, draw}, state}
    else
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end

  def handle_call({:get_result, draw_id}, _from, state) do
    with {:ok, draw} <- Payfi.Draws.get_result(draw_id) do
      {:reply, {:ok, draw}, state}
    else
      _ -> {:reply, {:error, "Error getting draw result"}, state}
    end
  end
end
