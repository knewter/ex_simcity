defmodule ExSimcity.MapTest do
  use ExUnit.Case

  test "boundaries default to [100,100]" do
    map = ExSimcity.Map.new
    assert map.width  == 100
    assert map.height == 100
  end

  test "you can specify your own grid" do
    map = ExSimcity.Map.new(10, 15)
    assert map.width  == 15
    assert map.height == 10
  end


  test "returns a grid with those dimensions" do
    map = ExSimcity.Map.new
    grid = map.grid
    assert Enum.count(grid) == 100
    for line <- grid do
      assert Enum.count(line) == 100
    end
  end

  test "can find cell at a given coordinates" do
    map = ExSimcity.Map.new
    cell = map |> ExSimcity.Map.cell_at(2, 3)
    assert %ExSimcity.MapCell{} = cell
  end

  test "knows the row a given object is in" do
    object = %{id: 1}
    map = ExSimcity.Map.new
          |> ExSimcity.Map.put_in(object, 1, 1)

    assert map |> ExSimcity.Map.row_for_object(object) == map.grid |> Enum.at(1)
  end

  test "knows the point for a given object" do
    object = %{id: 1}
    map = ExSimcity.Map.new
          |> ExSimcity.Map.put_in(object, 1, 1)
    assert ExSimcity.Map.point_for_object(map, object) == [1,1]
  end
end
