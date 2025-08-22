defmodule Payfi.Draws do
  @moduledoc """
  The Draws context.
  """

  import Ecto.Query, warn: false
  alias Payfi.Repo

  alias Payfi.Draws.Draw

  @doc """
  Returns the list of draws.

  ## Examples

      iex> list_draws()
      [%Draw{}, ...]

  """
  def list_draws do
    Repo.all(Draw)
  end

  @doc """
  Gets a single draw.

  Raises `Ecto.NoResultsError` if the Draw does not exist.

  ## Examples

      iex> get_draw!(123)
      %Draw{}

      iex> get_draw!(456)
      ** (Ecto.NoResultsError)

  """
  def get_draw!(id), do: Repo.get!(Draw, id)

  @doc """
  Creates a draw.

  ## Examples

      iex> create_draw(%{field: value})
      {:ok, %Draw{}}

      iex> create_draw(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_draw(%{"name" => name, "date" => date}) do
    [year, month, day] =
      date
      |> String.split("/")
      |> Enum.map(fn item -> String.to_integer(item) end)

    {:ok, new_date} = Date.new(year, month, day)

    attrs = %{name: name, date: new_date}

    %Draw{}
    |> Draw.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a draw.

  ## Examples

      iex> update_draw(draw, %{field: new_value})
      {:ok, %Draw{}}

      iex> update_draw(draw, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_draw(%Draw{} = draw, attrs) do
    draw
    |> Draw.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a draw.

  ## Examples

      iex> delete_draw(draw)
      {:ok, %Draw{}}

      iex> delete_draw(draw)
      {:error, %Ecto.Changeset{}}

  """
  def delete_draw(%Draw{} = draw) do
    Repo.delete(draw)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking draw changes.

  ## Examples

      iex> change_draw(draw)
      %Ecto.Changeset{data: %Draw{}}

  """
  def change_draw(%Draw{} = draw, attrs \\ %{}) do
    Draw.changeset(draw, attrs)
  end
end
