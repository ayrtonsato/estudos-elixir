defmodule Exmeal.Users.Create do
  alias Exmeal.{Error, Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end

  defp handle_insert(result), do: result
end
