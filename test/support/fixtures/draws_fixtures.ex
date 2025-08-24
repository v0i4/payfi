defmodule Payfi.DrawsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Payfi.Draws` context.
  """

  @doc """
  Generate a draw.
  """
  def draw_fixture(attrs \\ %{}) do
    {:ok, draw} =
      attrs
      |> Enum.into(%{
        date: Date.utc_today(),
        name: "some name"
      })
      |> Payfi.Draws.create_draw()

    draw
  end
end
