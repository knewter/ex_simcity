defmodule ExSimcity.Map do
  @derive [Access]
  defstruct width: 100,
            height: 100,
            grid: {}

  def new(height \\ 100, width \\ 100) do
    initial_grid = rows(height, width)
    %__MODULE__{width: width, height: height, grid: initial_grid}
  end

  def cell_at(map, x, y) do
    map.grid |> Enum.at(x) |> Enum.at(y)
  end

  def put_in(map, object, x, y) do
    grid = map.grid
    row = grid
           |> Enum.at(y)
    cell = row
           |> Enum.at(x)
    new_cell = %ExSimcity.MapCell{cell | contents: cell.contents ++ [object]}
    new_row = row |> List.replace_at(x, new_cell)
    updated_grid = grid |> List.replace_at(y, new_row)

    %ExSimcity.Map{map | grid: updated_grid}
  end

  def row_for_object(map, object) do
    grid = map.grid
    row = Enum.find(grid, fn(row) ->
            Enum.find(row, fn(cell) ->
              Enum.any?(cell.contents, &(&1 == object))
            end)
          end)
  end

  def point_for_object(map, object) do
    row = row_for_object(map, object)
    y = Enum.find_index(map.grid, &(&1 == row))
    x = Enum.find_index(row, fn(cell) ->
          Enum.any?(cell.contents, &(&1 == object))
        end)
    [x,y]
  end

  ## Private API ##

  defp rows(height, width) do
    1..width
    |> Enum.map( fn(row) ->
         cells(height)
       end)
  end

  defp cells(height) do
    1..height
    |> Enum.map( fn(_) ->
         %ExSimcity.MapCell{}
       end)
  end
end
