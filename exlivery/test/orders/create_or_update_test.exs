defmodule ExliveryTest.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup %{} do
      Exlivery.start_agents()
      cpf = "123456789"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Pizza de pepperoni",
        quantity: 2,
        unity_price: "35.5"
      }

      item2 = %{
        category: :pizza,
        description: "Pizza de calabresa",
        quantity: 2,
        unity_price: "31.5"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdateOrder.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{
        user_cpf: "1111111111",
        items: [item1, item2]
      }

      response = CreateOrUpdateOrder.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when there are no items, returns an error", %{
      user_cpf: cpf
    } do
      params = %{
        user_cpf: cpf,
        items: []
      }

      response = CreateOrUpdateOrder.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
