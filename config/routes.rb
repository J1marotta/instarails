Rails.application.routes.draw do
  resources :posts

  devise_for :users
	root to: "photos#index"

  # act as votable gem
  resources  :photos do
  member do
    put "like", to: "photo#upvote"
    put "dislike", to: "photo#downvote"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
