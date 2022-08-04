defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{User, Error}
  alias Rockelivery.Users.Create
  alias Rockelivery.ViaCep.ClientMock

  import Rockelivery.Factory
  import Mox

  describe "call/1" do
    test "when all params are valid, returns a valid user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert %User{id: _id, age: 27, email: "ayreton@asidj.com"} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"age" => 15, "password" => "123"})

      response = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
