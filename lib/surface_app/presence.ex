defmodule SurfaceApp.Presence do
  use Phoenix.Presence, otp_app: :surface_app,
                        pubsub_server: SurfaceApp.PubSub
  
end