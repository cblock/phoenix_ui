defmodule Phoenix.UI.Components.DropdownTest do
  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "dropdown/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.dropdown id="dropdown-test">
        <:toggle>
          toggle content
        </:toggle>
        <:menu>
          menu content
        </:menu>
      </.dropdown>
      """

      html = rendered_to_string(markup)

      assert html =~ "id=\"dropdown-test\""
      assert html =~ "toggle content"
      assert html =~ "menu content"
    end

    test "should raise when missing id", %{assigns: assigns} do
      markup = ~H"""
      <.dropdown>
        <:toggle>
          toggle content
        </:toggle>
        <:menu>
          menu content
        </:menu>
      </.dropdown>
      """

      assert_raise KeyError, ~r/key :id not found/, fn ->
        rendered_to_string(markup)
      end
    end

    test "should raise when missing toggle", %{assigns: assigns} do
      markup = ~H"""
      <.dropdown id="dropdown-test">
        <:menu>
          menu content
        </:menu>
      </.dropdown>
      """

      assert_raise KeyError, ~r/key :toggle not found/, fn ->
        rendered_to_string(markup)
      end
    end

    test "should raise when missing menu", %{assigns: assigns} do
      markup = ~H"""
      <.dropdown id="dropdown-test">
        <:toggle>
          toggle content
        </:toggle>
      </.dropdown>
      """

      assert_raise KeyError, ~r/key :menu not found/, fn ->
        rendered_to_string(markup)
      end
    end
  end
end
