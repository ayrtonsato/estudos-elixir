defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 27,
      "address" => "Rua das",
      "cep" => "12345678",
      "cpf" => "12345678900",
      "email" => "ayreton@asidj.com",
      "password" => "1234546667",
      "name" => "Ayrton"
    }
  end

  def user_factory do
    %User{
      age: 27,
      address: "Rua das",
      cep: "12345678",
      cpf: "12345678900",
      email: "ayreton@asidj.com",
      password: "1234546667",
      name: "Ayrton",
      id: "0c721236-d88f-4227-832a-50390154d8da"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
