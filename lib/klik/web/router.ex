defmodule Klik.Web.Router do
  use Klik.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{
      "content-security-policy" => Application.get_env(:klik, :csp)
    }
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Klik.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/counters", CounterController, except: [:index, :new, :delete] do
      resources "/increments", IncrementController, only: [:create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Klik.Web do
  #   pipe_through :api
  # end
end
