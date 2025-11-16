defmodule FileUploadDemo.BucketTest do
  use FileUploadDemo.DataCase

  alias FileUploadDemo.Bucket

  describe "bucks" do
    alias FileUploadDemo.Bucket.Bucks

    import FileUploadDemo.BucketFixtures

    @invalid_attrs %{id: nil, name: nil}

    test "list_bucks/0 returns all bucks" do
      bucks = bucks_fixture()
      assert Bucket.list_bucks() == [bucks]
    end

    test "get_bucks!/1 returns the bucks with given id" do
      bucks = bucks_fixture()
      assert Bucket.get_bucks!(bucks.id) == bucks
    end

    test "create_bucks/1 with valid data creates a bucks" do
      valid_attrs = %{id: "some id", name: "some name"}

      assert {:ok, %Bucks{} = bucks} = Bucket.create_bucks(valid_attrs)
      assert bucks.id == "some id"
      assert bucks.name == "some name"
    end

    test "create_bucks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bucket.create_bucks(@invalid_attrs)
    end

    test "update_bucks/2 with valid data updates the bucks" do
      bucks = bucks_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name"}

      assert {:ok, %Bucks{} = bucks} = Bucket.update_bucks(bucks, update_attrs)
      assert bucks.id == "some updated id"
      assert bucks.name == "some updated name"
    end

    test "update_bucks/2 with invalid data returns error changeset" do
      bucks = bucks_fixture()
      assert {:error, %Ecto.Changeset{}} = Bucket.update_bucks(bucks, @invalid_attrs)
      assert bucks == Bucket.get_bucks!(bucks.id)
    end

    test "delete_bucks/1 deletes the bucks" do
      bucks = bucks_fixture()
      assert {:ok, %Bucks{}} = Bucket.delete_bucks(bucks)
      assert_raise Ecto.NoResultsError, fn -> Bucket.get_bucks!(bucks.id) end
    end

    test "change_bucks/1 returns a bucks changeset" do
      bucks = bucks_fixture()
      assert %Ecto.Changeset{} = Bucket.change_bucks(bucks)
    end
  end

  describe "bucks" do
    alias FileUploadDemo.Bucket.Bucks

    import FileUploadDemo.BucketFixtures

    @invalid_attrs %{name: nil, timestamp: nil}

    test "list_bucks/0 returns all bucks" do
      bucks = bucks_fixture()
      assert Bucket.list_bucks() == [bucks]
    end

    test "get_bucks!/1 returns the bucks with given id" do
      bucks = bucks_fixture()
      assert Bucket.get_bucks!(bucks.id) == bucks
    end

    test "create_bucks/1 with valid data creates a bucks" do
      valid_attrs = %{name: "some name", timestamp: "some timestamp"}

      assert {:ok, %Bucks{} = bucks} = Bucket.create_bucks(valid_attrs)
      assert bucks.name == "some name"
      assert bucks.timestamp == "some timestamp"
    end

    test "create_bucks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bucket.create_bucks(@invalid_attrs)
    end

    test "update_bucks/2 with valid data updates the bucks" do
      bucks = bucks_fixture()
      update_attrs = %{name: "some updated name", timestamp: "some updated timestamp"}

      assert {:ok, %Bucks{} = bucks} = Bucket.update_bucks(bucks, update_attrs)
      assert bucks.name == "some updated name"
      assert bucks.timestamp == "some updated timestamp"
    end

    test "update_bucks/2 with invalid data returns error changeset" do
      bucks = bucks_fixture()
      assert {:error, %Ecto.Changeset{}} = Bucket.update_bucks(bucks, @invalid_attrs)
      assert bucks == Bucket.get_bucks!(bucks.id)
    end

    test "delete_bucks/1 deletes the bucks" do
      bucks = bucks_fixture()
      assert {:ok, %Bucks{}} = Bucket.delete_bucks(bucks)
      assert_raise Ecto.NoResultsError, fn -> Bucket.get_bucks!(bucks.id) end
    end

    test "change_bucks/1 returns a bucks changeset" do
      bucks = bucks_fixture()
      assert %Ecto.Changeset{} = Bucket.change_bucks(bucks)
    end
  end
end
