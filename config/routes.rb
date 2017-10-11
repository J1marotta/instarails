Rails.application.routes.draw do

  devise_for :users
	root to: "photos#index"


  # nested routes allow for new_photo_comment routes so the comments are attached to the photos

  resources  :photos do
    resources :comments
  member do
    # act as votable gem
    put "like", to: "photos#upvote"
    put "dislike", to: "photos#downvote"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
