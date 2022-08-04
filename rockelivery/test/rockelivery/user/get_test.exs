defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.ViaCep.ClientMock

  describe "Get user" do
    test "when a valid id is given, returns an user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      user = Rockelivery.create_user(params)

      response = Rockelivery.get_user_by_id(user.id)

      assert {:ok, %{age: 27, name: "Ayrton", email: "ayreton@asidj.com"}} = response
    end

    test "when an invalid id is given, returns an error" do
      response = Rockelivery.get_user_by_id("70a9e0d3-e01d-4dbe-906d-fe70196d3017")

      assert {:error, %{status: :not_found, result: "User not found!"}} = response
    end
  end
end
