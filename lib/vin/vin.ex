defmodule Vin.Vin do
  @moduledoc """
  Houses logic for validating VINs
  """

  @length 17

  @transliterations 0..9
                    |> Enum.reduce(%{}, &Map.put(&2, to_string(&1), &1))
                    |> Map.merge(%{
                      "A" => 1,
                      "B" => 2,
                      "C" => 3,
                      "D" => 4,
                      "E" => 5,
                      "F" => 6,
                      "G" => 7,
                      "H" => 8,
                      "J" => 1,
                      "K" => 2,
                      "L" => 3,
                      "M" => 4,
                      "N" => 5,
                      "P" => 7,
                      "R" => 9,
                      "S" => 2,
                      "T" => 3,
                      "U" => 4,
                      "V" => 5,
                      "W" => 6,
                      "X" => 7,
                      "Y" => 8,
                      "Z" => 9
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

  @spec check_digit(term()) :: {:ok, binary()} | {:error, binary()}
  def check_digit(vin) do
    if is_valid?(vin) do
      calculate_check_digit(vin)
    else
      {:error, "Invalid VIN"}
    end
  end

  def is_valid?(vin) when is_binary(vin) do
    is_valid_length?(vin) and is_all_allowed_symbols?(vin)
  end

  def is_valid?(_vin), do: false

  def is_all_allowed_symbols?(vin) when is_binary(vin) do
    Enum.all?(String.graphemes(vin), &Map.has_key?(@transliterations, &1))
  end

  defp is_valid_length?(vin) when is_binary(vin) do
    String.length(vin) == @length
  end

  defp calculate_check_digit(vin) do
    check_digit =
      case vin
           |> String.graphemes()
           |> Enum.with_index(1)
           |> Enum.reduce(0, fn {vin_symbol, position}, sum ->
             sum + @transliterations[vin_symbol] * @position_weights[position]
           end)
           |> rem(11) do
        10 -> "X"
        single_digit -> to_string(single_digit)
      end

    {:ok, check_digit}
  end
end
