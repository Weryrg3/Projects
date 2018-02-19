defmodule Geometry.Rectangle do
  defstruct [:length, :height]
  def new(length, height) do
    %Geometry.Rectangle{length: length, height: height}
  end
end

defimpl Geometry.Shape, for: Geometry.Rectangle do
  def area(rectangle) do
    rectangle.length * rectangle.height
  end
  def perimeter(rectangle) do
    rectangle.length * 2 + rectangle.height * 2
  end
end

