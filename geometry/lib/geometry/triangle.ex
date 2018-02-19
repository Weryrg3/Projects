defmodule Geometry.Triangle do
  defstruct [:length, :height]
  def new(length, height) do
    %Geometry.Triangle{length: length, height: height}
  end
end

defimpl Geometry.Shape, for: Geometry.Triangle do
  
end