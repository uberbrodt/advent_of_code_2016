defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "R direction matches" do 
    assert Day1.final_location(["R2"], {0,0}, Day1.north) == {2,0}
  end 

  test "L direction even number mods x axis" do
    assert Day1.final_location(["L2"], {0,0}, Day1.north) == {-2,0}
  end

  test "[R2, L3] should return coordinates of {2, 3}" do 
    assert Day1.final_location(["R2", "L3"], {0,0}, Day1.north) == {2,3}
  end

  test "R2 L3 should be distance of 5 blocks" do
    assert Day1.distance(["R2", "L3"], {0,0}, Day1.north) == 5
  end

  test "distance_to_repeat R8, R4, R4, R8 should be distance of 4 blocks" do
    assert Day1.distance_to_repeat(["R8", "R4", "R4", "R8"]) == 4
  end

  test "find_first_repeating R8, R4, R4, R8 should return ok " do
    assert Day1.find_first_repeating(["R8", "R4", "R4", "R8"]) == {4,0}
  end

  test "test that we get all coordinates on path" do 
    assert Day1.get_coordinates_on_path(8, "R", [], {0,0}, Day1.north) 
    == {:no, {{8, 0}, 1}, [{1, 0}, {2, 0}, {3, 0}, {4, 0},
                                                 {5, 0}, {6, 0}, {7, 0}]}
  end
end
