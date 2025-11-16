defmodule FileUploadDemoWeb.BucksLiveTest do
  use FileUploadDemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import FileUploadDemo.BucketFixtures

  @create_attrs %{name: "some name", timestamp: "some timestamp"}
  @update_attrs %{name: "some updated name", timestamp: "some updated timestamp"}
  @invalid_attrs %{name: nil, timestamp: nil}

  defp create_bucks(_) do
    bucks = bucks_fixture()
    %{bucks: bucks}
  end

  describe "Index" do
    setup [:create_bucks]

    test "lists all bucks", %{conn: conn, bucks: bucks} do
      {:ok, _index_live, html} = live(conn, ~p"/bucks")

      assert html =~ "Listing Bucks"
      assert html =~ bucks.name
    end

    test "saves new bucks", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bucks")

      assert index_live |> element("a", "New Bucks") |> render_click() =~
               "New Bucks"

      assert_patch(index_live, ~p"/bucks/new")

      assert index_live
             |> form("#bucks-form", bucks: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bucks-form", bucks: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bucks")

      html = render(index_live)
      assert html =~ "Bucks created successfully"
      assert html =~ "some name"
    end

    test "updates bucks in listing", %{conn: conn, bucks: bucks} do
      {:ok, index_live, _html} = live(conn, ~p"/bucks")

      assert index_live |> element("#bucks-#{bucks.id} a", "Edit") |> render_click() =~
               "Edit Bucks"

      assert_patch(index_live, ~p"/bucks/#{bucks}/edit")

      assert index_live
             |> form("#bucks-form", bucks: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bucks-form", bucks: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bucks")

      html = render(index_live)
      assert html =~ "Bucks updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes bucks in listing", %{conn: conn, bucks: bucks} do
      {:ok, index_live, _html} = live(conn, ~p"/bucks")

      assert index_live |> element("#bucks-#{bucks.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucks-#{bucks.id}")
    end
  end

  describe "Show" do
    setup [:create_bucks]

    test "displays bucks", %{conn: conn, bucks: bucks} do
      {:ok, _show_live, html} = live(conn, ~p"/bucks/#{bucks}")

      assert html =~ "Show Bucks"
      assert html =~ bucks.name
    end

    test "updates bucks within modal", %{conn: conn, bucks: bucks} do
      {:ok, show_live, _html} = live(conn, ~p"/bucks/#{bucks}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucks"

      assert_patch(show_live, ~p"/bucks/#{bucks}/show/edit")

      assert show_live
             |> form("#bucks-form", bucks: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bucks-form", bucks: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bucks/#{bucks}")

      html = render(show_live)
      assert html =~ "Bucks updated successfully"
      assert html =~ "some updated name"
    end
  end
end
