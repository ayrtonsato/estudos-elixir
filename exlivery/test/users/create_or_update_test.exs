defmodule ExliveryTest.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate, as: CreateOrUpdateUser

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "Ayrton",
        email: "ayrton@teste.com",
        address: "Rua das bananas",
        cpf: "123456789",
        age: 30
      }

      response = CreateOrUpdateUser.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Ayrton",
        email: "ayrton@teste.com",
        address: "Rua das bananas",
        cpf: "123456789",
        age: 10
      }

      response = CreateOrUpdateUser.call(params)

      expected_response = {:error, "Invalid params"}

      assert response == expected_response
    end
  end
end
