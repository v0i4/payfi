defmodule Payfi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Payfi.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> Payfi.Accounts.create_user()

    user
  end
end
