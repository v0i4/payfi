defmodule Payfi.Utils do
  def get_error_message(%Ecto.Changeset{} = changeset) do
    with false <- changeset.valid? do
      changeset.errors
      |> Enum.map(fn {key, value} -> "#{key} #{value |> elem(0)}" end)
      |> Enum.join(", ")
    end
  end

  def get_error_message(error) do
    error
  end
end
