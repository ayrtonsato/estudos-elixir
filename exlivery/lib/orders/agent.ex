defmodule Exlivery.Orders.Agent do
  alias Exlivery.Orders.Order

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_sate(&1, order, uuid))
    {:ok, uuid}
  end

  def update_sate(state, %Order{} = order, uuid), do: Map.put(state, uuid, order)

  def get(uuid), do: Agent.get(__MODULE__, &get_user(&1, uuid))

  def get_user(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  def list_all, do: Agent.get(__MODULE__, & &1)
end
