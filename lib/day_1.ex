defmodule Day1 do

  @directions  ["R2", "L3", "R2", "R4", "L2", "L1", "R2", "R4", "R1", "L4",
                "L5", "R5","R5", "R2", "R2", "R1", "L2", "L3", "L2", "L1",
                "R3", "L5", "R187", "R1", "R4", "L1", "R5", "L3", "L4", "R50",
                "L4","R2","R70", "L3", "L2", "R4","R3", "R194", "L3", "L4",
                "L4", "L3", "L4", "R4", "R5", "L1", "L5", "L4", "R1", "L2",
                "R4","L5", "L3", "R4", "L5", "L5", "R5", "R3", "R5", "L2","L4",
                "R4", "L1", "R3", "R1", "L1", "L2", "R2", "R2", "L3", "R3",
                "R2", "R5", "R2", "R5", "L3", "R2", "L5", "R1", "R2", "R2",
                "L4", "L5", "L1", "L4", "R4", "R3", "R1", "R2", "L1", "L2",
                "R4", "R5", "L2", "R3", "L4", "L5", "L5", "L4", "R4", "L2",
                "R1", "R1", "L2", "L3", "L2", "R2", "L4", "R3", "R2", "L1",
                "L3", "L2", "L4", "L4", "R2", "L3", "L3", "R2", "L4", "L3",
                "R4", "R3", "L2", "L1", "L4", "R4", "R2", "L4", "L4", "L5",
                "L1", "R2", "L5", "L2", "L3", "R2", "L2"]

  @north  0
  @east  1
  @south 2
  @west 3


  def final_location(dirs, pos, dir) do
    if length(dirs) == 0 do 
      pos 
    else 
      coord = get_coordinates(hd(dirs), pos, dir)
      final_location(tl(dirs), elem(coord, 0), elem(coord, 1))
    end
  end

  def get_coordinates(direction, origin, facing) do
    case direction do
      "R" <> blocks when facing == @north -> 
        {increment_x(origin, String.to_integer(blocks)), @east}
      "R" <> blocks when facing == @east -> 
        {decrement_y(origin, String.to_integer(blocks)), @south}
      "R" <> blocks when facing == @south -> 
        {decrement_x(origin, String.to_integer(blocks)), @west}
      "R" <> blocks when facing == @west -> 
        {increment_y(origin, String.to_integer(blocks)), @north}
      "L" <> blocks when facing == @north -> 
        {decrement_x(origin, String.to_integer(blocks)), @west}
      "L" <> blocks when facing == @south -> 
        {increment_x(origin, String.to_integer(blocks)), @east}
      "L" <> blocks when facing == @east -> 
        {increment_y(origin, String.to_integer(blocks)), @north}
      "L" <> blocks when facing == @west -> 
        {decrement_y(origin, String.to_integer(blocks)), @south}
    end
  end

  def find_first_repeating(dirs, prev_locations \\ [], current_location \\ {0,0},
        facing \\ @north) do

    if length(dirs) == 0 do 
      raise "no repeats found"
    else
      result = case hd(dirs) do
        "R" <> cnt ->
          result = get_coordinates_on_path(String.to_integer(cnt), "R", prev_locations,
                                           current_location, facing)
        "L" <> cnt -> 
          result = get_coordinates_on_path(String.to_integer(cnt), "L", prev_locations,
                                           current_location, facing)
      end
      case result do
        {:ok, new_coordinate} -> new_coordinate
        {:no, new_location, prev_locations} -> 
          find_first_repeating(tl(dirs), prev_locations, elem(new_location, 0),
                                elem(new_location, 1)) 
      end
    end
  end

  def get_coordinates_on_path(cnt, walking_direction, prev_locations, current_location,
        facing) do 
    if cnt == 1 do
      loc = get_coordinates(walking_direction <> "1", current_location, facing)
      {:no, loc, prev_locations}
    else 
      loc = get_coordinates(walking_direction <> "1", current_location, facing)
      new_coordinate = elem(loc, 0)
      if new_coordinate in prev_locations do 
        {:ok, new_coordinate}
      else 
        get_coordinates_on_path(cnt - 1, walking_direction, (prev_locations ++
                                [new_coordinate]), new_coordinate, facing)
      end
    end
  end

  def distance_to_repeat(dirs) do
    coordinate = find_first_repeating(dirs)
    abs(elem(coordinate, 0)) + abs(elem(coordinate, 1))
  end

  defp increment_x(pos, value) do
    put_elem(pos, 0, elem(pos, 0) + value)
  end 

  defp increment_y(pos, value) do
    put_elem(pos, 1, elem(pos, 1) + value)
  end

  defp decrement_x(pos, value) do
    put_elem(pos, 0, elem(pos, 0) - value)
  end

  defp decrement_y(pos, value) do
    put_elem(pos, 1, elem(pos, 1) - value)
  end

  def distance(directions, origin \\ {0,0}, starting_dir \\ @north) do
    coordinates = final_location(directions, origin, starting_dir)
    abs(elem(origin, 0) - elem(coordinates,0)) + abs(elem(origin, 1) -
        elem(coordinates, 1))
  end

  def north, do: @north
  def south, do: @south
  def east, do: @east
  def west, do: @west
  def easter_bunny_hq_directions, do: @directions

  def run do
  end
end
