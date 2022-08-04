defmodule Exmeal.Meals.Create do
  alias Exmeal.{Error, Repo, Meal}

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end

  defp handle_insert(result), do: result
end
