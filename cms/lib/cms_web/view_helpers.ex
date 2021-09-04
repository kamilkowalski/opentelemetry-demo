defmodule CmsWeb.ViewHelpers do
  @button_classes """
  text-center text-white font-bold block rounded bg-purple-500 p-2 hover:bg-purple-400 transition-colors
  """
  def link_button(text, opts \\ []) do
    opts = Keyword.merge([class: @button_classes], opts)
    Phoenix.HTML.Link.link(text, opts)
  end

  def submit_button(text, opts \\ []) do
    opts = Keyword.merge([class: @button_classes], opts)
    Phoenix.HTML.Form.submit(text, opts)
  end

  # Tailwind classes cannot be dynamic, otherwise purging doesn't work
  @bg_color_mapping %{
    :info => "bg-blue-100",
    :error => "bg-red-100"
  }

  @border_color_mapping %{
    :info => "border-blue-400",
    :error => "border-red-400"
  }

  @alert_colors [:info, :error]

  def alert_box(type, text) when type in @alert_colors do
    bg_color = @bg_color_mapping[type]
    border_color = @border_color_mapping[type]
    classes = "rounded #{bg_color} #{border_color} border-2 hide-empty p-4 my-4"
    Phoenix.HTML.Tag.content_tag(:p, text, role: "alert", class: classes)
  end
end
