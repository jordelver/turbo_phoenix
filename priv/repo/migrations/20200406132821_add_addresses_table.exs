defmodule TurboPhoenix.Repo.Migrations.AddAddressesTable do
  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :uuid, column: :id)
      add :address1, :string
      add :address2, :string
      add :town, :string
      add :postcode, :string
      add :country, :string
      timestamps()
    end
  end
end
