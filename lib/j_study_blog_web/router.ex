defmodule JStudyBlogWeb.Router do
  use JStudyBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JStudyBlogWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/vocabs", VocabController
  end

  # Other scopes may use custom stacks.
  # scope "/api", JStudyBlogWeb do
  #   pipe_through :api
  # end
end
