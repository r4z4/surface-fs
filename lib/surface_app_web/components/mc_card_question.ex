defmodule SurfaceAppWeb.Components.McCardQuestion do
    # This component will have some state. So use the stateful component.
    use Surface.Component

    prop question_text, :string, required: true

    def render(assigns) do
        ~F"""
          <div class="grid rounded-lg shadow-lg bg-white max-w-sm text-center justify-self-center">
              { @question_text }
          </div>
        """
    end

end