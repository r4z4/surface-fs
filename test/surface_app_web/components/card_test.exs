defmodule SurfaceAppWeb.Components.CardTest do
  use SurfaceAppWeb.ConnCase, async: true
  use Surface.LiveViewTest

  catalogue_test SurfaceAppWeb.Card
end
