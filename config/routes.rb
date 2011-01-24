Rails.application.routes.draw do
  post '/auth/accounts', :to => 'freeberry_auth/accounts#create', :as => :auth_accounts
  post '/auth/vkontakte', :to => 'freeberry_auth/accounts#vkontakte', :as => :auth_vkontakte
  get '/auth/logout', :to => 'freeberry_auth/accounts#logout', :as => :auth_logout
end
