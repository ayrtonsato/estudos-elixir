defmodule Rockelivery.Items.Create do
  alias Rockelivery.{Repo, Item, Error}

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Item{} = result}), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
