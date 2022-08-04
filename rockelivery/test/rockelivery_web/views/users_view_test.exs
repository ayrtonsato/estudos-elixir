defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "xpot12345"

    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: "xpot12345",
             user: %Rockelivery.User{
               address: "Rua das",
               age: 27,
               cep: "12345678",
               cpf: "12345678900",
               email: "ayreton@asidj.com",
               id: "0c721236-d88f-4227-832a-50390154d8da",
               inserted_at: nil,
               name: "Ayrton",
               password: "1234546667",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
