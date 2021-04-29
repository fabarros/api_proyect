Rails.application.routes.draw do
  resources :tracks do
    put "/play", to: "tracks#play"
  end
  resources :albums do
    post "/tracks", to: "tracks#create"
    get "/tracks", to: "albums#tracks"
    put "/play", to: "albums#play"
  end
  resources :artists do
    post "/albums", to: "albums#create"
    get "/albums", to: "artists#albums"
    get "/tracks", to: "artists#tracks"
    put "/albums/play", to: "artists#play"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
