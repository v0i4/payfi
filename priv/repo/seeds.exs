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
# antonio =
# %Payfi.Accounts.User{
#   name: "Antonio",
#   email: "HtUoH@example.com"
# }
# |> Payfi.Repo.insert!()
#
# maria =
# %Payfi.Accounts.User{
#   name: "Maria",
#   email: "maria@example.com"
# }
# |> Payfi.Repo.insert!()
#
# fulano =
# %Payfi.Accounts.User{
#   name: "fulano",
#   email: "fulano@example.com"
# }
# |> Payfi.Repo.insert!()
#
# beltrano =
# %Payfi.Accounts.User{
#   name: "beltrano",
#   email: "beltrano@example.com"
# }
# |> Payfi.Repo.insert!()
#
# draw =
# %Payfi.Draws.Draw{
#   name: "Draw 1",
#   date: Date.utc_today(),
#   active: true
# }
# |> Payfi.Repo.insert!()
#
# %Payfi.Participations.Participation{
# user_id: antonio.id,
# draw_id: draw.id
# }
# |> Payfi.Repo.insert!()
#
# %Payfi.Participations.Participation{
# user_id: maria.id,
# draw_id: draw.id
# }
# |> Payfi.Repo.insert!()
#
# %Payfi.Participations.Participation{
# user_id: fulano.id,
# draw_id: draw.id
# }
# |> Payfi.Repo.insert!()
#
# %Payfi.Participations.Participation{
# user_id: beltrano.id,
# draw_id: draw.id
# }
# |> Payfi.Repo.insert!()
