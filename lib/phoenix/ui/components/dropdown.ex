defmodule Phoenix.UI.Components.Dropdown do
  @moduledoc """
  Provides dropdown component.
  """
  import Phoenix.UI.Components.Menu

  use Phoenix.UI, :component

  attr(:id, :string, required: true)

  slot(:menu, required: true)
  slot(:toggle, required: true)

  @doc """
  Renders dropdown component.

  ## Examples

      ```
      <.dropdown id="basic_dropdown">
        <:toggle>
          Toggle Dropdown
        </:toggle>
        <:menu>

        </:menu>
      </.drawer>
      ```

  """
  @spec dropdown(Socket.assigns()) :: Rendered.t()
  def dropdown(assigns) do
    IO.inspect(assigns.menu, label: "MENU")
    IO.inspect(assigns.toggle, label: "TOGGLE")

    ~H"""
    <div id={@id} class="relative inline-block dropdown" phx-click-away={close_dropdown("##{@id}")}>
      <div class="dropdown-toggle" phx-click={toggle_dropdown("##{@id}")}>
        <%= render_slot(@toggle) %>
      </div>
      <.menu element="div" extend_class="dropdown-menu hidden absolute top right-0 mt-2 z-20">
        <%= render_slot(@menu) %>
      </.menu>
    </div>
    """
  end

  ### JS Interactions ##########################

  @doc """
  Closes dropdown via matching selector.

  ## Examples

      iex> close_dropdown(selector)
      %JS{}

      iex> close_dropdown(js, selector)
      %JS{}

  """
  @spec close_dropdown(String.t()) :: struct()
  def close_dropdown(selector), do: close_dropdown(%JS{}, selector)

  @spec close_dropdown(struct(), String.t()) :: struct()
  def close_dropdown(%JS{} = js, selector), do: JS.hide(js, to: "#{selector} .dropdown-menu")

  @doc """
  Toggles dropdown via matching selector.

  ## Examples

      iex> toggle_dropdown(selector)
      %JS{}

      iex> toggle_dropdown(js, selector)
      %JS{}

  """
  @spec toggle_dropdown(String.t()) :: struct()
  def toggle_dropdown(selector), do: toggle_dropdown(%JS{}, selector)

  @spec toggle_dropdown(struct(), String.t()) :: struct()
  def toggle_dropdown(%JS{} = js, selector), do: JS.toggle(js, to: "#{selector} .dropdown-menu")
end
