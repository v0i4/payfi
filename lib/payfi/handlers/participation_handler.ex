defmodule Payfi.Handlers.ParticipationHandler do
  use GenServer

  alias Payfi.Participations

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    new_state = initialize_cache()
    {:ok, new_state}
  end

  def create_participation(params) do
    GenServer.call(__MODULE__, {:create_participation, params})
  end

  def handle_call({:create_participation, params}, _from, state) do
    user_id = params["user_id"]
    draw_id = params["draw_id"]
    record_key = {user_id, draw_id}

    if lookup_cache(record_key, state) do
      {:reply, {:error, "user_id has already been taken"}, state}
    else
      with {:ok, participation} <- Payfi.Participations.create_participation(params) do
        record = {params["user_id"], params["draw_id"]}
        new_state = [record | state]
        {:reply, {:ok, participation}, new_state}
      else
        {:error, reason} -> {:reply, {:error, reason}, state}
      end
    end
  end

  def handle_call({:lookup_cache, user_id, draw_id}, _from, state) do
    exists = Enum.member?(state, %{user_id: user_id, draw_id: draw_id})
    {:reply, {:cache, exists}, state}
  end

  def lookup_cache(record_key, state) do
    if Enum.member?(state, record_key) do
      IO.inspect("CACHE HIT")
      true
    else
      IO.inspect("CACHE MISS")
      false
    end
  end

  def initialize_cache() do
    Participations.list_participations()
    |> Enum.map(fn p -> {p.user_id, p.draw_id} end)
  end
end
