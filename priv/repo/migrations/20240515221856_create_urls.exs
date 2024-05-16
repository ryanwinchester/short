defmodule Short.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :full, :string, null: false
      add :short, :string, null: false
      add :count, :integer, null: false, default: 0
      timestamps(type: :utc_datetime, updated_at: false)
    end

    create unique_index(:urls, [:short])
  end
end
