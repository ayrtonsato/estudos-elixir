defmodule ExliveryTest.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "save/1" do
    test "saves the order" do
      order = build(:order)

      OrderAgent.start_link(%{})
      assert {:ok, _} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "when the order is found, returns the order" do
      {:ok, uuid} =
        :order
        |> build()
        |> OrderAgent.save()

      response = OrderAgent.get(uuid)

      expected_response = {
        :ok,
        %Order{
          delivery_addres: "Rua das bananas",
          items: [
            %Item{
              category: :pizza,
              description: "Pizza pepperoni",
              quantity: 2,
              unity_price: Decimal.new("35.5")
            },
            %Item{
              category: :japonesa,
              description: "Temaki de atum",
              quantity: 2,
              unity_price: Decimal.new("20.50")
            }
          ],
          total_price: Decimal.new("112.00"),
          user_cpf: "123456789"
        }
      }

      assert response == expected_response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("123456789")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
