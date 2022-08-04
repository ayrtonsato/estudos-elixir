defmodule Exmeal.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add(:date, :date)
      add(:description, :string)
      add(:calories, :integer)

      timestamps()
    end
  end
end
