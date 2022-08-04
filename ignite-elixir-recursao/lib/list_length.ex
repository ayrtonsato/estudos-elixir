require Logger

defmodule ListLength do

  def call(list) do
    if list == [] do
      0
    else
      [_ | tail] = list
      ListLength.call(tail, 1)
    end
  end

  def call([_ | tail], length) do
    if (tail) do
      call(tail, length + 1)
    else
      length
    end
  end

  def call([], length) do
    length
  end
end
