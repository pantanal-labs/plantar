defmodule Plantar.Search do
  import Ecto.Query, warn: false

  alias Plantar.Repo
  alias Plantar.Plant.Crop

  def find_crops(query, offset: offset, limit: limit)
      when is_binary(query) do
    terms = Regex.split(~r/[\s\.-_]/, String.downcase(query))
    base_query = projects_base_query(terms)

    results =
      base_query
      |> offset(^offset)
      |> limit(^limit)
      |> order_by(desc: :updated_at)
      |> preload([:user])
      |> Repo.all()

    %{results: results, total_count: base_query |> Repo.aggregate(:count)}
  end

  def find_crops(_query, _opts), do: %{results: [], total_count: 0}

  defp projects_base_query(terms) do
    Crop
    #|> where(status: ^:published)
    |> where_all_terms_match(terms, &matches_crop/2)
  end

  defp where_all_terms_match(query, terms, fun) do
    Enum.reduce(terms, query, fun)
  end

  def matches_crop(term, query) do
    from crop in query,
      where:
        ilike(crop.name, ^"%#{term}%") or
          ilike(crop.description, ^"%#{term}%") or
          ilike(crop.alternatives_names, ^"%#{term}%")
  end
end
