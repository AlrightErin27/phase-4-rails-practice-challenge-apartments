Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tenants
  resources :apartments
  resources :leases, except: %i[index update show]
end
