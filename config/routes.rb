Rails.application.routes.draw do
  resources :urls

  root to: 'urls#index'
  get '*shortened_link' => 'urls#redirect'
end
