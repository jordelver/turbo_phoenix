defmodule TurboPhoenix.Schema.User do
  use TurboPhoenix.Schema

  alias TurboPhoenix.Schema.Address

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    has_one :address, Address
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :username, :email])
    |> validate_required([:first_name, :last_name, :username, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
