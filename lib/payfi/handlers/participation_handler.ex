defmodule Payfi.Handlers.ParticipationHandler do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def create_participation(params) do
    GenServer.call(__MODULE__, {:create_participation, params})
  end

  def handle_call({:create_participation, params}, _from, state) do
    with {:ok, participation} <- Payfi.Participations.create_participation(params) do
      {:reply, {:ok, participation}, state}
    else
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end
end
