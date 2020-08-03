defmodule Plantar.PlantFixtures do

  alias Plantar.Plant

  import Plantar.AccountsFixtures

  @valid_attrs %{alternatives_names: "some alternatives_names", binomial_name: "some binomial_name", days_of_maturity: 42, description: "some description", height: 42, name: "some name", row_spacing: 42, sun_requirements: "some sun_requirements"}

  def crop_fixture(attrs \\ %{}) do
    user = user_fixture()

    with_user = %{user_id: user.id}
      |> Enum.into(@valid_attrs)

    {:ok, crop} =
      attrs
      |> Enum.into(with_user)
      |> Plant.create_crop()

    crop
  end
end
