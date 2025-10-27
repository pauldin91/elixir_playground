defmodule MvcDemo.CmsTest do
  use MvcDemo.DataCase

  alias MvcDemo.Cms

  describe "pages" do
    alias MvcDemo.Cms.Page

    import MvcDemo.CmsFixtures

    @invalid_attrs %{title: nil, body: nil, views: nil}

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Cms.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Cms.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      valid_attrs = %{title: "some title", body: "some body", views: 42}

      assert {:ok, %Page{} = page} = Cms.create_page(valid_attrs)
      assert page.title == "some title"
      assert page.body == "some body"
      assert page.views == 42
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cms.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body", views: 43}

      assert {:ok, %Page{} = page} = Cms.update_page(page, update_attrs)
      assert page.title == "some updated title"
      assert page.body == "some updated body"
      assert page.views == 43
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Cms.update_page(page, @invalid_attrs)
      assert page == Cms.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Cms.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Cms.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Cms.change_page(page)
    end
  end
end
