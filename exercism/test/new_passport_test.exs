defmodule NewPassportTest do
  use ExUnit.Case

  test "getting into the building entering during business hour" do
    assert {:ok, _} = NewPassport.get_new_passport(~N[2021-10-11 15:00:00], ~D[1984-09-14], :blue)
  end
end
