Rails.application.routes.draw do
  resources :urls

  root to: 'urls#index'
  get 'top' => 'urls#top'
  get '*shortened_link' => 'urls#redirect'
end
