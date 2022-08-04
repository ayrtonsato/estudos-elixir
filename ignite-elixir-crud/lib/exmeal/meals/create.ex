defmodule Exmeal.Meals.Create do
  alias Exmeal.{Repo, Error, Meal}

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{} = meal}), do: {:ok, meal}

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
