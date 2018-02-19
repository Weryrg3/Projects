defmodule Geometry.Square do
  defstruct [:size]
  def new(size) do
    %Geometry.Square{size: size}
  end
end

defimpl Geometry.Shape, for: Geometry.Square do
  def area(square) do
    square.size * square.size
  end
  def perimeter(square) do
    square.size * 4
  end
end

