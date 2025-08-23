defmodule Payfi.Handlers.UserHandler do
  use GenServer
  alias Payfi.Accounts

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def create_user(params) do
    GenServer.call(__MODULE__, {:create_user, params})
  end

  def handle_call({:create_user, params}, _from, state) do
    with {:ok, user} <- Accounts.create_user(params) do
      {:reply, {:ok, user}, state}
    else
      {:error, reason} -> {:reply, {:error, reason}, state}
      _ -> {:reply, {:error, "Error creating user"}, state}
    end
  end

  def handle_call({:get_user, email}, _from, state) do
    user = Accounts.get_user!(email)
    {:reply, {:ok, user}, state}
  end
end
