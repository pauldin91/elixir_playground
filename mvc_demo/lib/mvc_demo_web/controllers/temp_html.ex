defmodule MvcDemoWeb.TempHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use MvcDemoWeb, :html

  embed_templates "temp_html/*"
end
