defmodule ExliveryTest.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})
      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the user is found, returns the user" do
      :user
      |> build(cpf: "123456789")
      |> UserAgent.save()

      response = UserAgent.get("123456789")

      expected_response =
        {:ok,
         %Exlivery.Users.User{
           address: "Rua das bananas",
           age: 30,
           cpf: "123456789",
           email: "valid_email@test.com",
           name: "Ayrton"
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("123456789")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
