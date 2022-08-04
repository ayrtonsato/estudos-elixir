require Enum
require Integer
require Float

defmodule ListFilter do

  def call(list) do
    Enum.filter(
      list,
      fn element ->
        result = Integer.parse(element)
        if result != :error do
          {n, _} = result
          if rem(n, 2) == 1 do
            n
          end
        end
      end
    )
  end
end
