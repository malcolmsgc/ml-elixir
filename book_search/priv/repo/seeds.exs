# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BookSearch.Repo.insert!(%BookSearch.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Explorer.DataFrame, as: DF

path = "priv/repo/booksummaries/booksummaries.txt"

df = DF.from_csv!(path, delimiter: "\t", header: false)
df = df[["column_3", "column_4", "column_7"]]
df = DF.rename(df, ["title", "author", "description"])

df
|> DF.to_rows()
|> Enum.each(&BookSearch.Library.create_book/1)
