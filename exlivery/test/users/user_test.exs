defmodule ExliveryTest.Users.User do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response = User.build("Rua das bananas", "Ayrton", "valid_email@test.com", "123456789", 30)

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("Rua das bananas", "Ayrton", "valid_email@test.com", "123456789", 17)

      expected_response = {:error, "Invalid params"}

      assert response == expected_response
    end
  end
end
