Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  # Reply ----------------------------------------
  post 'replies/create' => 'replies#create'

  get 'replies/destroy/:id' => 'replies#destroy'

  # Post ---------------------------------
  get 'posts/new'
  post'posts/create'

  get 'posts/index'
 
  get 'posts/show/:id' => 'posts#show'
 
  get 'posts/edit/:id' => 'posts#edit'
  post'posts/update/:id' => 'posts#update'
 
  get 'posts/destroy/:id' => 'posts#destroy'
  
  get 'posts/search'
  # Post ---------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
