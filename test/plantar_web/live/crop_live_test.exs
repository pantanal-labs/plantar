defmodule PlantarWeb.CropLiveTest do
  use PlantarWeb.ConnCase

  import Phoenix.LiveViewTest
  import Plantar.AccountsFixtures
  import Plantar.PlantFixtures


  @create_attrs %{alternatives_names: "some alternatives_names", binomial_name: "some binomial_name", days_of_maturity: 42, description: "some description", height: 42, name: "some name", row_spacing: 42, sun_requirements: "some sun_requirements"}
  @update_attrs %{alternatives_names: "some updated alternatives_names", binomial_name: "some updated binomial_name", days_of_maturity: 43, description: "some updated description", height: 43, name: "some updated name", row_spacing: 43, sun_requirements: "some updated sun_requirements"}
  @invalid_attrs %{alternatives_names: nil, binomial_name: nil, days_of_maturity: nil, description: nil, height: nil, name: nil, row_spacing: nil, sun_requirements: nil}


  defp create_crop(_) do
    crop = crop_fixture()
    %{crop: crop}
  end

  describe "Index" do
    setup [:create_crop]

    test "lists all crops", %{conn: conn, crop: crop} do
      {:ok, _index_live, html} = live(conn, Routes.crop_index_path(conn, :index))

      assert html =~ "Listing Crops"
      assert html =~ crop.alternatives_names
    end

    test "saves new crop", %{conn: conn} do
      user = user_fixture()

      conn = conn |> log_in_user(user)

      {:ok, index_live, _html} = live(conn, Routes.crop_index_path(conn, :index))

      assert index_live |> element("a", "New Crop") |> render_click() =~
               "New Crop"

      assert_patch(index_live, Routes.crop_index_path(conn, :new))

      assert index_live
             |> form("#crop-form", crop: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#crop-form", crop: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.crop_index_path(conn, :index))

      assert html =~ "Crop created successfully"
      assert html =~ "some alternatives_names"
    end

    test "updates crop in listing", %{conn: conn, crop: crop} do
      {:ok, index_live, _html} = live(conn, Routes.crop_index_path(conn, :index))

      assert index_live |> element("#crop-#{crop.id} a", "Edit") |> render_click() =~
               "Edit Crop"

      assert_patch(index_live, Routes.crop_index_path(conn, :edit, crop))

      assert index_live
             |> form("#crop-form", crop: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#crop-form", crop: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.crop_index_path(conn, :index))

      assert html =~ "Crop updated successfully"
      assert html =~ "some updated alternatives_names"
    end

    test "deletes crop in listing", %{conn: conn, crop: crop} do
      {:ok, index_live, _html} = live(conn, Routes.crop_index_path(conn, :index))

      assert index_live |> element("#crop-#{crop.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#crop-#{crop.id}")
    end
  end

  describe "Show" do
    setup [:create_crop]

    test "displays crop", %{conn: conn, crop: crop} do
      {:ok, _show_live, html} = live(conn, Routes.crop_show_path(conn, :show, crop))

      assert html =~ "Show Crop"
      assert html =~ crop.binomial_name
    end

    test "updates crop within modal", %{conn: conn, crop: crop} do
      {:ok, show_live, _html} = live(conn, Routes.crop_show_path(conn, :show, crop))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Crop"

      assert_patch(show_live, Routes.crop_show_path(conn, :edit, crop))

      assert show_live
             |> form("#crop-form", crop: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#crop-form", crop: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.crop_show_path(conn, :show, crop))

      assert html =~ "Crop updated successfully"
      assert html =~ "some updated alternatives_names"
    end
  end
end
