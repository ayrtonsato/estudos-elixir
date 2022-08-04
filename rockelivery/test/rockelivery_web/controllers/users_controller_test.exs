defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 27,
        "address" => "Rua das",
        "cep" => "12345678",
        "cpf" => "12345678900",
        "email" => "ayreton@asidj.com",
        "password" => "1234546667",
        "name" => "Ayrton"
      }

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua das",
                 "age" => 27,
                 "cpf" => "12345678900",
                 "email" => "ayreton@asidj.com"
               }
             } = response
    end

    test "when there are some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "1234546667",
        "name" => "Ayrton"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is an user with the given id, deletes the user", %{conn: conn} do
      id = "0c721236-d88f-4227-832a-50390154d8da"
      response = conn |> delete(Routes.users_path(conn, :delete, id)) |> response(:no_content)

      assert response == ""
    end
  end

  describe "show/1" do
    test "when there is an user with the given id, returns the user", %{conn: conn} do
      id = "0c721236-d88f-4227-832a-50390154d8da"
      insert(:user)

      response = conn |> get(Routes.users_path(conn, :show, id)) |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "Rua das",
                 "age" => 27,
                 "cpf" => "12345678900",
                 "email" => "ayreton@asidj.com",
                 "id" => "0c721236-d88f-4227-832a-50390154d8da"
               }
             } = response
    end

    test "when invalid id is given, returns an error", %{conn: conn} do
      id = "70a9e0d3-e01d-4dbe-906d-fe70196d3017"
      response = conn |> delete(Routes.users_path(conn, :show, id)) |> json_response(:not_found)
      expected_response = %{"message" => "User not found!"}
      assert response == expected_response
    end

    test "when an invalid uuid is given, returns invalid uuid error", %{conn: conn} do
      id = "70a9e0d3-e01d-4dbe-906d"
      response = conn |> delete(Routes.users_path(conn, :show, id)) |> json_response(:bad_request)
      expected_response = %{"message" => "Invalid UUID"}
      assert response == expected_response
    end
  end

  describe "udpate/1" do
    test "when all params are valid, updates the user", %{conn: conn} do
      insert(:user)

      params = %{
        id: "0c721236-d88f-4227-832a-50390154d8da",
        email: "teste@teste.com",
        age: 20
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, params.id), params)
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "Rua das",
                 "age" => 20,
                 "cpf" => "12345678900",
                 "email" => "teste@teste.com",
                 "id" => "0c721236-d88f-4227-832a-50390154d8da"
               }
             } = response
    end

    test "when invalid id is given, returns an error", %{conn: conn} do
      id = "70a9e0d3-e01d-4dbe-906d-fe70196d3017"

      response =
        conn
        |> put(Routes.users_path(conn, :update, id), %{
          id: "0c721236-d88f-4227-832a-50390154d8da",
          email: "teste@teste.com"
        })
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}
      assert response == expected_response
    end
  end
end
