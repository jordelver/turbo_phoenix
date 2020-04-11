defmodule TurboPhoenix.Schema.Address do
  use TurboPhoenix.Schema

  alias TurboPhoenix.Schema.User

  schema "addresses" do
    field :address1, :string
    field :address2, :string
    field :town, :string
    field :postcode, :string
    field :country, :string
    belongs_to :user, User
    timestamps()
  end

  def changeset(address, params \\ %{}) do
    address
    |> cast(params, [:address1, :address2, :town, :postcode, :country])
    |> validate_required([:address1, :town, :postcode, :country])
  end

  def changeset_with_user(address, user, params \\ %{}) do
    address
    |> cast(params, [:address1, :address2, :town, :postcode, :country])
    |> validate_required([:address1, :town, :postcode, :country])
    |> put_assoc(:user, user)
  end
end
