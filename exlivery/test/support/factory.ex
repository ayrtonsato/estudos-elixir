defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Ayrton",
      email: "valid_email@test.com",
      cpf: "123456789",
      age: 30,
      address: "Rua das bananas"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza pepperoni",
      category: :pizza,
      unity_price: Decimal.new("35.5"),
      quantity: 2
    }
  end

  def order_factory do
    %Order{
      user_cpf: "123456789",
      delivery_addres: "Rua das bananas",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.50")
        )
      ],
      total_price: Decimal.new("112.00")
    }
  end
end
