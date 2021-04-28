defmodule Vin.Seeds do
  def run do
    case Mix.env() do
      :dev -> run_dev()
      _ -> nil
    end
  end

  def run_dev do
  end
end
