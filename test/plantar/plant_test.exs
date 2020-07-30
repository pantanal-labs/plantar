defmodule Plantar.PlantTest do
  use Plantar.DataCase

  alias Plantar.Plant

  describe "crops" do
    alias Plantar.Plant.Crop

    @valid_attrs %{alternatives_names: "some alternatives_names", binomial_name: "some binomial_name", days_of_maturity: 42, description: "some description", height: 42, name: "some name", row_spacing: 42, sun_requirements: "some sun_requirements"}
    @update_attrs %{alternatives_names: "some updated alternatives_names", binomial_name: "some updated binomial_name", days_of_maturity: 43, description: "some updated description", height: 43, name: "some updated name", row_spacing: 43, sun_requirements: "some updated sun_requirements"}
    @invalid_attrs %{alternatives_names: nil, binomial_name: nil, days_of_maturity: nil, description: nil, height: nil, name: nil, row_spacing: nil, sun_requirements: nil}

    def crop_fixture(attrs \\ %{}) do
      {:ok, crop} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Plant.create_crop()

      crop
    end

    test "list_crops/0 returns all crops" do
      crop = crop_fixture()
      assert Plant.list_crops() == [crop]
    end

    test "get_crop!/1 returns the crop with given id" do
      crop = crop_fixture()
      assert Plant.get_crop!(crop.id) == crop
    end

    test "create_crop/1 with valid data creates a crop" do
      assert {:ok, %Crop{} = crop} = Plant.create_crop(@valid_attrs)
      assert crop.alternatives_names == "some alternatives_names"
      assert crop.binomial_name == "some binomial_name"
      assert crop.days_of_maturity == 42
      assert crop.description == "some description"
      assert crop.height == 42
      assert crop.name == "some name"
      assert crop.row_spacing == 42
      assert crop.sun_requirements == "some sun_requirements"
    end

    test "create_crop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plant.create_crop(@invalid_attrs)
    end

    test "update_crop/2 with valid data updates the crop" do
      crop = crop_fixture()
      assert {:ok, %Crop{} = crop} = Plant.update_crop(crop, @update_attrs)
      assert crop.alternatives_names == "some updated alternatives_names"
      assert crop.binomial_name == "some updated binomial_name"
      assert crop.days_of_maturity == 43
      assert crop.description == "some updated description"
      assert crop.height == 43
      assert crop.name == "some updated name"
      assert crop.row_spacing == 43
      assert crop.sun_requirements == "some updated sun_requirements"
    end

    test "update_crop/2 with invalid data returns error changeset" do
      crop = crop_fixture()
      assert {:error, %Ecto.Changeset{}} = Plant.update_crop(crop, @invalid_attrs)
      assert crop == Plant.get_crop!(crop.id)
    end

    test "delete_crop/1 deletes the crop" do
      crop = crop_fixture()
      assert {:ok, %Crop{}} = Plant.delete_crop(crop)
      assert_raise Ecto.NoResultsError, fn -> Plant.get_crop!(crop.id) end
    end

    test "change_crop/1 returns a crop changeset" do
      crop = crop_fixture()
      assert %Ecto.Changeset{} = Plant.change_crop(crop)
    end
  end
end
