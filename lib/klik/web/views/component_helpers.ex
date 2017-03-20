defmodule Klik.Web.ComponentHelpers do
  def component(template, assigns) do
    Klik.Web.ComponentView.render(template, assigns)
  end

  def component(template, assigns, do: block) do
    Klik.Web.ComponentView.render(template, Keyword.merge(assigns, [do: block]))
  end
end
