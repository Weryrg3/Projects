defmodule Geometry.Circle do
  defstruct [:radius]
  def new(radius) do
    %Geometry.Circle{radius: radius}
  end
end

defimpl Geometry.Shape, for: Geometry.Circle do
  def area(circle) do
    :math.pi * :math.pow(circle.radius, 2)
  end
  def perimeter(circle) do
    2 * :math.pi * circle.radius
  end
end
