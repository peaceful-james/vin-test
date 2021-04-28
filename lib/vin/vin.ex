defmodule Vin.Vin do
  @moduledoc """
  Houses logic for validating VINs
  """

  @length 17

  @transliterations
  0..9
  |> Enum.reduce(%{}, &Map.put(&2, to_string(&1), &1))
  |> Map.merge(%{
    "A" => 1,
    "B" => 2,
    "C" => 3,
    "D" => 3,
    "E" => 3,
    "F" => 3,
    "G" => 3,
    "H" => 3,
    "I" => nil,
    "J" => 3,
    "K" => 3,
    "L" => 3,
    "M" => 3,
    "N" => 3,
    "O" => nil,
    "P" => 3,
    "Q" => nil,
    "R" => 3,
    "S" => 3,
    "T" => 3,
    "U" => 3,
    "V" => 3,
    "W" => 3,
    "X" => 3,
    "Y" => 3,
    "Z" => 3
  })

  @position_weights %{
    1 => 8,
    2 => 7,
    3 => 6,
    4 => 5,
    5 => 4,
    6 => 3,
    7 => 2,
    8 => 10,
    9 => 0,
    10 => 9,
    11 => 8,
    12 => 7,
    13 => 6,
    14 => 5,
    15 => 4,
    16 => 3,
    17 => 2
  }

  def is_valid_length?(vin) when is_binary(vin) do
    String.length(vin) == @length
  end

  def is_valid_length?(vin), do: false

  def check_digit(vin) do
    if is_valid_length?(vin) do
      calculate_check_digit(vin)
    else
      nil
    end
  end

  defp calculate_check_digit(vin) do
    "HYu"
  end
end
