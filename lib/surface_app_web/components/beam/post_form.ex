defmodule SurfaceAppWeb.Components.Beam.PostForm do
  use Surface.LiveComponent
  alias SurfaceAppWeb.Components.Utils.{Heading}
  alias SurfaceApp.Timeline.Post
  alias SurfaceApp.Timeline
  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field, TextArea, Checkbox}
  alias SurfaceAppWeb.Components.Utils.{Heading, SubmitButton}
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  prop user_info, :tuple
  prop username, :string
  prop posts, :list

  prop post, :any

  data post_body, :string, default: ""
  data post_private, :boolean, default: false

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
<div class="border-solid border-1 border-sky-500/50 rounded-md" >
  <div class="flex justify-center">
    <Form for={:post} id="post-form" class="justify-center w-full" change="validate" submit="save">
        <Field name="private">
          <!-- Component starts here -->
          <a class="group max-w-max relative mx-1 flex flex-row items-center justify-center p-1 text-gray-500 hover:bg-gray-200 hover:text-gray-600" href="#">
              <!-- Text/Icon goes here -->
              <Label>Private?</Label><Checkbox class="px-2" id="private" click="toggle_private" />
              <!--<p class="text-xs text-center">Hover Me</p>-->
              <!-- Tooltip here -->
              <div class="[transform:perspective(50px)_translateZ(0)_rotateX(10deg)] group-hover:[transform:perspective(0px)_translateZ(0)_rotateX(0deg)] absolute bottom-0 mb-6 origin-bottom transform rounded text-white opacity-0 transition-all duration-300 group-hover:opacity-100">
                  <div class="flex max-w-xs flex-col items-center">
                      <div class="rounded bg-gray-900 p-2 text-xs text-center shadow-lg">Private messages will only be seen by your followers</div>
                      <div class="clip-bottom h-2 w-4 bg-gray-900"></div>
                  </div>
              </div>
          </a>
          <!-- Component ends here -->
        </Field>
      <Field name="title">
        <div class="control">
          <TextInput 
            name="title" 
            class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            opts={placeholder: "Post Title ... "} 
          />
        </div>
      </Field>
      <Field name="body">
        <div class="control">
          <TextArea 
            rows="2"
            cols="10"
            name="body" 
            class="block p-2.5 mt-2 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            opts={placeholder: "Your message..."} 
          />
        </div>
      </Field>
      <div class="flex-1">
        <SubmitButton kind="is-submit" label="Submit Post" />
      </div>
    </Form>
  </div>
</div>
    """
  end

  defp gravatar_url(email \\ "aaron@aaron.com") do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  def handle_event("toggle_private", _value, socket) do
    current_state = socket.assigns.post_private
    {:noreply,
      socket
      |> assign(post_private: !current_state)}
  end

  def handle_event("validate", _value, socket) do
    IO.inspect(socket.assigns.post_private, label: "Private?")
    {:noreply, socket}
  end

  def handle_event("save", %{"body" => body, "title" => title, "post" => %{"private" => private}}, socket) do
    IO.inspect(socket.assigns.post_private, label: "Private?")
    uname = Kernel.elem(socket.assigns.user_info, 2) 
    u_id = Kernel.elem(socket.assigns.user_info, 1) 
    IO.inspect(body, label: "Post Body")
    IO.inspect(private, label: "Post Private")
    attrs = %{title: title, body: body, likes_count: 0, reposts_count: 0, username: uname, user_id: u_id, private: private}
    Timeline.create_post(attrs)
    Process.send(self(), %{event: "refetch_posts", payload: u_id}, [:noconnect])
    # Run through changeset and save
    {:noreply, socket}
  end
end