defmodule Plantar.Plant.Crop do
  use Ecto.Schema
  import Ecto.Changeset
  alias Plantar.Accounts.User

  schema "crops" do
    field :alternatives_names, :string
    field :binomial_name, :string
    field :days_of_maturity, :integer
    field :description, :string
    field :height, :integer
    field :name, :string
    field :row_spacing, :integer
    field :sun_requirements, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(crop, attrs) do
    crop
    |> cast(attrs, [:name, :user_id, :alternatives_names, :binomial_name, :description, :height, :row_spacing, :days_of_maturity, :sun_requirements])
    |> validate_required([:name, :user_id, :binomial_name, :description])
  end
end
