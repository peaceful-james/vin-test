defmodule Vin.VinTest do
  use ExUnit.Case
  alias Vin.Vin

  describe "check digit calculation" do
    test "is_valid?/1 validates VIN string length" do
      string_of_ones = fn rng -> rng |> Enum.map(fn _ -> "1" end) |> Enum.join() end
      refute string_of_ones.(1..16) |> Vin.is_valid?()
      assert string_of_ones.(1..17) |> Vin.is_valid?()
      refute string_of_ones.(1..18) |> Vin.is_valid?()
    end

    test "is_valid?/1 validates all symbols in the VIN are allowed" do
      refute Vin.is_valid?("!@#$%^&*()GHGHGHG")
      refute Vin.is_valid?("1M8GDM9A_KP042788")
      assert Vin.is_valid?("1M8GDM9AXKP042788")
      assert Vin.is_valid?("11111111111111111")
    end

    test "check_digit/1" do
      assert Vin.check_digit("invalid") == {:error, "Invalid VIN"}
      assert Vin.check_digit("1M8GDM9AXKP042788") == {:ok, "X"}
      assert Vin.check_digit("11111111111111111") == {:ok, "1"}
    end
  end
end
