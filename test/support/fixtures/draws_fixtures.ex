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
        date: ~D[2025-08-21],
        name: "some name"
      })
      |> Payfi.Draws.create_draw()

    draw
  end
end
