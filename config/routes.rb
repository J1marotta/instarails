Rails.application.routes.draw do

  devise_for :users
	root to: "photos#index"


  # resource for profiles this only allows the current user to get to a profile and edit, if you're not signed in you can only view
  resources :user, only: [:show, :update], controller: :profiles
  #  resource vs recourses singular allows for just one profile and we tie it to the user id,
  #  if you use resources it adds profile/id/ for multiple users
  resource :profile

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
