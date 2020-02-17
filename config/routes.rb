Rails.application.routes.draw do
  root to: 'home#new', as: :new
  get '/score', to: 'home#score'
  post '/score', to: 'home#score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
