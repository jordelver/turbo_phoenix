defmodule TurboPhoenix.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :email, :string
      timestamps()
    end

    create index("users", [:username], unique: true)
    create index("users", [:email], unique: true)
  end
end
