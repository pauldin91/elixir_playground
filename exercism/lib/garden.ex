defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @plants %{"C" => :clover, "G" => :grass, "R" => :radish, "V" => :violet}
  @students %{
    :alice => "",
    :bob => "",
    :charlie => "",
    :david => "",
    :eve => "",
    :fred => "",
    :ginny => "",
    :harriet => "",
    :ileana => "",
    :joseph => "",
    :kincaid => "",
    :larry => ""
  }
  @spec info(String.t(), list) :: map
  def info(info_string, student_names) do
  end
end
