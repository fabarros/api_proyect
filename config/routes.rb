Rails.application.routes.draw do
<<<<<<< HEAD
  resources :tracks do
    
  end
  resources :albums do
    post "/tracks", to: "tracks#create"
    get "/tracks", to: "albums#tracks"
  end
  resources :artists do
    post "/albums", to: "albums#create"
    get "/albums", to: "artists#albums"
    get "/tracks", to: "artists#tracks"
  end
=======
  resources :artists
>>>>>>> 1e422ef9d12f18e0ce15f086ef016cdbb72b1819
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
