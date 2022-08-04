defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.User
  alias Rockelivery.ViaCep.ClientMock

  describe "Update User" do
    test "when a valid id is given, update the user" do
      user_params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      user = Rockelivery.create_user(user_params)

      update_params = %{
        "id" => user.id,
        "name" => "Pedro",
        "email" => "teste@valid.com"
      }

      response = Rockelivery.update_user(update_params)

      assert {:ok,
              %User{
                address: "Rua das",
                cep: "12345678",
                cpf: "12345678900",
                email: "teste@valid.com",
                name: "Pedro"
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      update_params = %{
        "id" => "70a9e0d3-e01d-4dbe-906d-fe70196d3017",
        "name" => "Pedro"
      }

      response = Rockelivery.update_user(update_params)

      assert {:error, %{status: :not_found, result: "User not found!"}} = response
    end
  end
end
