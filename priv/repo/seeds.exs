# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Payfi.Repo.insert!(%Payfi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# user =
# %Payfi.Accounts.User{
#   name: "Antonio",
#   email: "HtUoH@example.com"
# }
# |> Payfi.Repo.insert!()
#
# draw =
# %Payfi.Draws.Draw{
#   name: "Draw 1",
#   date: Date.new(2025, 1, 1) |> elem(1),
#   active: true
# }
# |> Payfi.Repo.insert!()
#
# participation =
# %Payfi.Participations.Participation{
#   user_id: user.id,
#   draw_id: draw.id
# }
# |> Payfi.Repo.insert!()
