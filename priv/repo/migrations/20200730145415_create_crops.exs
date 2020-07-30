defmodule Plantar.Repo.Migrations.CreateCrops do
  use Ecto.Migration

  def change do
    create table(:crops) do
      add :name, :string
      add :alternatives_names, :string
      add :binomial_name, :string
      add :description, :text
      add :height, :integer
      add :row_spacing, :integer
      add :days_of_maturity, :integer
      add :sun_requirements, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:crops, [:user_id])
  end
end
