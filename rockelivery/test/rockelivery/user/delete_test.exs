defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.User
  alias Rockelivery.ViaCep.ClientMock

  describe "Delete User" do
    test "when a valid id is given, delete the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      user = Rockelivery.create_user(params)

      response = Rockelivery.delete_user(user.id)

      assert {:ok,
              %User{
                address: "Rua das",
                cep: "12345678",
                cpf: "12345678900",
                email: "ayreton@asidj.com",
                name: "Ayrton"
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      response = Rockelivery.delete_user("70a9e0d3-e01d-4dbe-906d-fe70196d3017")

      assert {:error, %{status: :not_found, result: "User not found!"}} = response
    end
  end
end
