defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> draw_image
    |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, grid: [h | t]}) do
    [fill_rectangle(h, color) | draw_image(%Identicon.Image{color: color, grid: t})]
  end

  def fill_rectangle({{sh, sv}, {th, tv}}, {r, g, b}) do
    for x <- sh..(th - 1), y <- sv..(tv - 1), do: {x, y, r, g, b}
  end

  def build_grid(%Identicon.Image{hex: hex} = image, size \\ 3) do
    %Identicon.Image{
      image
      | grid:
          hex
          |> Enum.chunk_every(size)
          |> Enum.take_while(fn list -> length(list) == size end)
          |> Enum.map(fn list -> list ++ tl(Enum.reverse(list)) end)
          |> Enum.map(fn list -> Enum.filter(list, fn num -> rem(num, 2) == 0 end) end)
          |> List.flatten()
          |> Enum.with_index()
          |> Enum.map(fn {_, index} ->
            h = rem(index, 5) * 50
            v = div(index, 5) * 50
            {{h, v}, {h + 50, v + 50}}
          end)
    }
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
